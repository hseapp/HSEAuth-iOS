import AuthenticationServices
import SafariServices

enum Constants {
    static let scheme = "https"
    static let host = "auth.hse.ru"
    static let authUrl = URL(string: "https://auth.hse.ru/adfs/oauth2/authorize/")
    static let responseType = "code"
    static let redirectScheme = "ru.hse.pf://"
    static let redirectUrl = "\(redirectScheme)\(host)/adfs/oauth2/ios/ru.hse.pf/callback"
    static let scope = ["profile", "openid"]
}

public class AuthManager: NSObject {
    private weak var anchor: ASPresentationAnchor?
    let networkClient: NetworkClient

    public init(with anchor: ASPresentationAnchor) {
        self.anchor = anchor
        networkClient = NetworkClient(
            scheme: Constants.scheme,
            host: Constants.host
        )
    }
}

extension AuthManager: ASWebAuthenticationPresentationContextProviding {
    @available(iOS 12.0, *)
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        guard let anchor = anchor else { preconditionFailure("anchor is not set") }
        return anchor
    }

}

public protocol AuthManagerProtocol: class {
    var session: NSObject? { get set }
    var authManager: AuthManager? { get set }
    func auth(_ completion: @escaping (Result<AccessTokenResponse, Error>) -> Void)
}
