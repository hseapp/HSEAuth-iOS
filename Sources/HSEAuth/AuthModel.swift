import AuthenticationServices
import SafariServices

public class AuthModel {

    private let clientId: String

    public var session: NSObject? = nil
    public var authManager: AuthManager?
    private var config: OpenIdConfigResponse?
    private let networkClient: NetworkClient
    
    private let loginCallback: RedirectCallback
    private let logoutCallback: RedirectCallback

    public init(
        with clientId: String,
        host: String,
        loginCallback: RedirectCallback,
        logoutCallback: RedirectCallback
    ) {
        self.clientId = clientId
        networkClient = NetworkClient(host: host)
        self.loginCallback = loginCallback
        self.logoutCallback = logoutCallback
    }

    func authMethod(url: URL, callbackScheme: String) -> Result<URL, Error> {
        var result: Result<URL, Error>!
        let semaphore = DispatchSemaphore(value: 0)

        if #available(iOS 12, *) {
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme)
            {
                if let resultUrl = $0 {
                    result = .success(resultUrl)
                }
                if let error = $1 {
                    result = .failure(error)
                }
                semaphore.signal()
            }
            if #available(iOS 13.0, *) {
                session.presentationContextProvider = authManager
            }
            session.start()
            self.session = session
        } else {
            let session = SFAuthenticationSession(url: url, callbackURLScheme: callbackScheme)
            {
                if let resultUrl = $0 {
                    result = .success(resultUrl)
                }
                if let error = $1 {
                    result = .failure(error)
                }
                semaphore.signal()
            }
            session.start()
            self.session = session
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }

    func getAccessToken(for code: String) -> Result<AccessTokenResponse, Error> {
        let request = AccessTokenRequest(code: code, clientId: clientId, redirectUrl: loginCallback.redirectString())
        return networkClient.search(request: request)
    }

    func getCode() -> Result<String, Error> {
        guard let authUrl = URL(string: config?.authorizationEndpoint ?? "") else { preconditionFailure("something wrong") }

        let urlComponents = URLComponents(url: authUrl, resolvingAgainstBaseURL: false)?
            .add(key: "response_type", value: "code")
            .add(key: "client_id", value: clientId)
            .add(key: "redirect_uri", value: loginCallback.redirectString())
            .add(key: "scope", value: ["profile", "openid"].joined(separator: " "))
        
        guard let url = urlComponents?.url else { preconditionFailure("something wrong") }
        
        return authMethod(url: url, callbackScheme: loginCallback.scheme)
            .flatMap {
                guard
                    let components = URLComponents(
                        url: $0,
                        resolvingAgainstBaseURL: false
                    ),
                    let code = (
                        components.queryItems?
                            .first(where: { $0.name == "code" })
                            .flatMap { $0.value }
                    )
                else { preconditionFailure("something wrong") }
                return .success(code)
            }
    }

    func getOpenIdConfig() -> Result<OpenIdConfigResponse, Error> {
        let request = OpenIdConfigRequest()
        return networkClient.search(request: request)
            .flatMap { [weak self] result -> Result<OpenIdConfigResponse, Error> in
                self?.config = result
                return .success(result)
        }
    }
}

extension AuthModel: AuthManagerProtocol {
    public func auth() -> Result<AccessTokenResponse, Error> {
        return getOpenIdConfig()
            .flatMap { [weak self] in
                guard let self = self else { preconditionFailure() }
                self.config = $0
                return self.getCode()
            }
            .flatMap { getAccessToken(for: $0) }
    }
    
    public func refreshAccessToken(with refreshToken: String) -> Result<AccessTokenResponse, Error> {
        let request = RefreshAccessTokenRequest(clientId: clientId, refreshToken: refreshToken)
        return networkClient.search(request: request)
    }
    
    public func logout(callbackScheme: String) -> Result<URL, Error> {
        return getOpenIdConfig()
            .flatMap { [weak self] in
                guard let self = self,
                      let url = URL(string: $0.endSessionEndpoint )
                else { preconditionFailure() }
                
                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)?
                    .add(key: "post_logout_redirect_uri", value: logoutCallback.redirectString())
                guard let logoutUrl = urlComponents?.url else { preconditionFailure() }
                
                return self.authMethod(url: logoutUrl, callbackScheme: callbackScheme)
            }
    }
}
