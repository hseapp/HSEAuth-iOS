import AuthenticationServices
import SafariServices

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
    func auth() -> Result<AccessTokenResponse, Error>
    func refreshAccessToken(with refreshToken: String) -> Result<AccessTokenResponse, Error>
    func logout()
}
