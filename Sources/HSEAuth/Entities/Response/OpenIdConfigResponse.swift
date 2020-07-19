import Foundation

public struct OpenIdConfigResponse: Codable {
    let issuer: String
    let authorizationEndpoint: String
    let tokenEndpoint: String
    let jwksUri: String
    let tokenEndpointAuthMethodsSupported: [String]
    let responseTypesSupported: [String]
    let responseModesSupported: [String]
    let grantTypesSupported: [String]
    let subjectTypesSupported: [String]
    let scopesSupported: [String]
    let idTokenSigningAlgValuesSupported: [String]
    let tokenEndpointAuthSigningAlgValuesSupported: [String]
    let accessTokenIssuer: String
    let claimsSupported: [String]
    let microsoftMultiRefreshToken: Bool
    let userinfoEndpoint: String
    let endSessionEndpoint: String
    let asAccessTokenTokenBindingSupported: Bool
    let asRefreshTokenTokenBindingSupported: Bool
    let resourceAccessTokenTokenBindingSupported: Bool
    let opIdTokenTokenBindingSupported: Bool
    let rpIdTokenTokenBindingSupported: Bool
    let frontchannelLogoutSupported: Bool
    let frontchannelLogoutSessionSupported: Bool
    let deviceAuthorizationEndpoint: String

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
