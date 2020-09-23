import Foundation

public struct AccessTokenResponse: Codable {
    public let scope: String?
    public let accessToken: String
    public let resource: String?
    public let tokenType: String
    public let idToken: String
    public let expiresIn: Int
    public let refreshToken: String?
    public let refreshTokenExpiresIn: Int?

    enum CodingKeys: String, CodingKey {
        case scope, resource
        case accessToken = "access_token"
        case tokenType = "token_type"
        case idToken = "id_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
    }
    
    init(_ object: AccessTokenResponse, refreshToken: String, refreshTokenExpiresIn: Int) {
        self.scope = object.scope
        self.accessToken = object.accessToken
        self.resource = object.resource
        self.tokenType = object.tokenType
        self.idToken = object.idToken
        self.expiresIn = object.expiresIn
        self.refreshTokenExpiresIn = refreshTokenExpiresIn
        self.refreshToken = refreshToken
    }
}
