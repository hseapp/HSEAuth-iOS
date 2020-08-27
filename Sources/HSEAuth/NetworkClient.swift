import Foundation

public class NetworkClient {
    private let session = URLSession.shared

    private let scheme: String
    private let host: String

    public init(scheme: String = "https", host: String) {
        self.scheme = scheme
        self.host = host
    }

    func search<Request: HSERequest>(request: Request, limit: Int = 0) -> Result<Request.ResponseResult, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = request.host ?? host
        urlComponents.path = request.path

        guard let url = urlComponents.url else { preconditionFailure("error in url") }
        var sessionRequest = URLRequest(url: url)
        sessionRequest.httpMethod = request.method.string
        sessionRequest.httpBody = request.body

        var result: Result<Request.ResponseResult, Error>!

        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: sessionRequest) { data, response, error in
            if let errorUnwrapped = error {
                result = .failure(errorUnwrapped)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let dataUnwrapped = data else {
                result = .failure(NetworkClientError(id: 1, desription: "Empty data"))
                return
            }
            do {
                let object = try decoder.decode(Request.ResponseResult.self, from: dataUnwrapped)
                result = .success(object)
            } catch {
                result = .failure(error)
            }
            semaphore.signal()
        }
        .resume()

        _ = semaphore.wait(wallTimeout: .distantFuture)

        return result
    }
}

extension NetworkClient {
    public struct NetworkClientError: LocalizedError {
        public let id: Int
        let desription: String
        public var localizedDescription: String { return desription }
        public var errorDescription: String? { return desription }
    }
}
