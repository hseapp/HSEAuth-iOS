import Foundation

public struct OpenIdConfigResponse: Codable {
    public let issuer: String
    public let authorizationEndpoint: String
    public let tokenEndpoint: String
    public let jwksUri: String
    public let tokenEndpointAuthMethodsSupported: [String]
    public let responseTypesSupported: [String]
    public let responseModesSupported: [String]
    public let grantTypesSupported: [String]
    public let subjectTypesSupported: [String]
    public let scopesSupported: [String]
    public let idTokenSigningAlgValuesSupported: [String]
    public let tokenEndpointAuthSigningAlgValuesSupported: [String]
    public let accessTokenIssuer: String
    public let claimsSupported: [String]
    public let microsoftMultiRefreshToken: Bool
    public let userinfoEndpoint: String
    public let endSessionEndpoint: String
    public let asAccessTokenTokenBindingSupported: Bool
    public let asRefreshTokenTokenBindingSupported: Bool
    public let resourceAccessTokenTokenBindingSupported: Bool
    public let opIdTokenTokenBindingSupported: Bool
    public let rpIdTokenTokenBindingSupported: Bool
    public let frontchannelLogoutSupported: Bool
    public let frontchannelLogoutSessionSupported: Bool
    public let deviceAuthorizationEndpoint: String

    enum CodingKeys: String, CodingKey {
        case issuer
        case authorizationEndpoint = "authorization_endpoint"
        case tokenEndpoint = "token_endpoint"
        case jwksUri = "jwks_uri"
        case tokenEndpointAuthMethodsSupported = "token_endpoint_auth_methods_supported"
        case responseTypesSupported = "response_types_supported"
        case responseModesSupported = "response_modes_supported"
        case grantTypesSupported = "grant_types_supported"
        case subjectTypesSupported = "subject_types_supported"
        case scopesSupported = "scopes_supported"
        case idTokenSigningAlgValuesSupported = "id_token_signing_alg_values_supported"
        case tokenEndpointAuthSigningAlgValuesSupported = "token_endpoint_auth_signing_alg_values_supported"
        case accessTokenIssuer = "access_token_issuer"
        case claimsSupported = "claims_supported"
        case microsoftMultiRefreshToken = "microsoft_multi_refresh_token"
        case userinfoEndpoint = "userinfo_endpoint"
        case endSessionEndpoint = "end_session_endpoint"
        case asAccessTokenTokenBindingSupported = "as_access_token_token_binding_supported"
        case asRefreshTokenTokenBindingSupported = "as_refresh_token_token_binding_supported"
        case resourceAccessTokenTokenBindingSupported = "resource_access_token_token_binding_supported"
        case opIdTokenTokenBindingSupported = "op_id_token_token_binding_supported"
        case rpIdTokenTokenBindingSupported = "rp_id_token_token_binding_supported"
        case frontchannelLogoutSupported = "frontchannel_logout_supported"
        case frontchannelLogoutSessionSupported = "frontchannel_logout_session_supported"
        case deviceAuthorizationEndpoint = "device_authorization_endpoint"
    }
}
