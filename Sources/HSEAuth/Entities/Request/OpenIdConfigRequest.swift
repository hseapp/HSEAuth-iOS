import Foundation

public struct OpenIdConfigRequest: HSERequest {
    public typealias ResponseResult = OpenIdConfigResponse
    let method = RequestMethod.get
    public let path: String = "/adfs/.well-known/openid-configuration"
    let body: Data? = nil
}
