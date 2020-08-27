import Foundation

public struct StudentLogout: HSERequest {
    
    public typealias ResponseResult = LogoutResponse
    var host: String? = nil
    var method: RequestMethod = .post
    public var path: String = "/adfs/oauth2/logout"
    let body: Data?
    
    public init() {
        body = nil
    }
}
