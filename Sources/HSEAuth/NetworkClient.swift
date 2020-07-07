//
//  File.swift
//  
//
//  Created by Alexander Tooszovski on 07.07.2020.
//

import Foundation

public class NetworkClient {
    private let delay: TimeInterval
    private let session = URLSession.shared
    private var task: URLSessionTask?
    private var job: DispatchWorkItem?

    private let scheme: String
    private let host: String

    public init(delay: TimeInterval = 0.3, scheme: String, host: String) {
        self.delay = delay
        self.scheme = scheme
        self.host = host
    }

    func search<Request: HSERequest>(request: Request,
                                     limit: Int = 0,
                                     completion: @escaping (HSEResult<Request.ResponseResult>) -> ()) throws {
        invalidate()
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = request.path

        guard let url = urlComponents.url else { preconditionFailure("error in request") }
        var sessionRequest = URLRequest(url: url)
        sessionRequest.httpMethod = request.method.string
        sessionRequest.httpBody = request.body
        job = DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.task = self.session.dataTask(with: sessionRequest) { data, response, error in
                if let errorUnwrapped = error {
                    completion(.failure(errorUnwrapped))
                    return
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let dataUnwrapped = data else {
                    completion(.failure(NetworkClientError(id: 1, desription: "Empty data")))
                    return
                }
                do {
                    let object = try decoder.decode(Request.ResponseResult.self, from: dataUnwrapped)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
            self.task!.resume()
        })
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delay, execute: job!)
    }

    func invalidate() {
        task?.cancel()
        job?.cancel()
    }

    deinit { invalidate() }
}

extension NetworkClient {
    public struct NetworkClientError: LocalizedError {
        public let id: Int
        let desription: String
        public var localizedDescription: String { return desription }
        public var errorDescription: String? { return desription }
    }
}
