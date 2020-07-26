import Foundation

//TODO: Make requests from configuration response
public struct LogoutRequest: HSERequest {
    public typealias ResponseResult = LogoutResponse
    var method: RequestMethod = .post
    public var path: String = "/adfs/oauth2/logout"
    let body: Data?

    public init() {
        body = nil
    }
}
