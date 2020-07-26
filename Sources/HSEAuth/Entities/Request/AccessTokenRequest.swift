import Foundation

public struct AccessTokenRequest: HSERequest {
    public typealias ResponseResult = AccessTokenResponse
    var method: RequestMethod = .post
    public var path: String = "/adfs/oauth2/token/"
    let body: Data?

    public init(code: String, clientId: String, redirectUrl: String) {
        body = URLComponents()
            .add(key: "code", value: code)
            .add(key: "redirect_uri", value: redirectUrl)
            .add(key: "client_id", value: clientId)
            .add(key: "grant_type", value: "authorization_code")
            .percentEncodedQuery?
            .data(using: .utf8)
    }
}
