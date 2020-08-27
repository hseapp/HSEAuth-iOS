import Foundation

public struct RefreshAccessTokenRequest: HSERequest {
    public typealias ResponseResult = AccessTokenResponse
    var host: String? = nil
    var method: RequestMethod = .post
    public var path: String = "/adfs/oauth2/token/"
    let body: Data?

    public init(clientId: String, refreshToken: String) {
        body = URLComponents()
            .add(key: "client_id", value: clientId)
            .add(key: "refresh_token", value: refreshToken)
            .add(key: "grant_type", value: "refresh_token")
            .percentEncodedQuery?
            .data(using: .utf8)
    }
}
