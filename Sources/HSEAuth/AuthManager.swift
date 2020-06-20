import AuthenticationServices
import SafariServices

enum Constants {
    static let authUrl = URL(string: "https://auth.hse.ru/adfs/oauth2/authorize/")
    static let responseType = "code"
    static let redirectScheme = "ru.hse.pf://"
    static let redirectUrl = "\(redirectScheme)auth.hse.ru/adfs/oauth2/ios/ru.hse.pf/callback"
    static let scope = ["profile", "openid"]
}

public class AuthManager: NSObject {
    private weak var anchor: ASPresentationAnchor?

    public init(with anchor: ASPresentationAnchor) {
        self.anchor = anchor
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
    func auth(_ completion: @escaping (Result<String, Error>) -> Void)
}
