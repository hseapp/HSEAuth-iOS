import Foundation

public struct Logout: HSERequest {
    public typealias ResponseResult = LogoutResponse
    var method: RequestMethod = .post
    public var path: String = "/adfs/oauth2/logout"
    let body: Data? = nil
}
