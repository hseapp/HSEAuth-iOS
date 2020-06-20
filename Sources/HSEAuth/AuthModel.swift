import AuthenticationServices
import SafariServices

public class AuthModel {
    private let clientId: String

    public var session: NSObject? = nil
    public var authManager: AuthManager?

    public init(with clientId: String) {
        self.clientId = clientId
    }

    func auth(
        url: URL,
        callbackScheme: String,
        completion: @escaping (Result<URL, Error>) -> Void
    ) {
        if #available(iOS 12, *) {
            let session = ASWebAuthenticationSession(url: url,
                                                     callbackURLScheme: callbackScheme)
            {
               if let resultUrl = $0 {
                    completion(.success(resultUrl))
                }
                if let error = $1 {
                    completion(.failure(error))
                }
            }
            if #available(iOS 13.0, *) {
                session.presentationContextProvider = authManager
            }
            session.start()
            self.session = session
        } else {
            let session = SFAuthenticationSession(url: url,
                                                  callbackURLScheme: callbackScheme)
            {
                if let resultUrl = $0 {
                    completion(.success(resultUrl))
                }
                if let error = $1 {
                    completion(.failure(error))
                }
            }
            session.start()
            self.session = session
        }
    }
}

extension AuthModel: AuthManagerProtocol {
    public func auth(_ completion: @escaping (Result<String, Error>) -> Void) {
        guard let authUrl = Constants.authUrl else { preconditionFailure("something wrong") }

        var urlComponents = URLComponents(url: authUrl, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "response_type", value: Constants.responseType),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectUrl),
            URLQueryItem(name: "scope", value: Constants.scope.joined(separator: " "))
        ]

        guard let url = urlComponents?.url else { preconditionFailure("something wrong") }

        auth(
            url: url,
            callbackScheme: Constants.redirectScheme) {
                switch $0 {
                case .success(let url):
                    guard
                        let components = URLComponents(url: url,
                                                         resolvingAgainstBaseURL: false),
                        let code = (components.queryItems?
                            .first(where: { $0.name == "code" })
                            .flatMap { $0.value })
                    else { preconditionFailure("something wrong") }
                    completion(.success(code))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
