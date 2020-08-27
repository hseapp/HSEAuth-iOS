import Foundation

public struct EmployeeLogout: HSERequest {
    public typealias ResponseResult = LogoutResponse
    var host: String? = "login.microsoftonline.com"

    var method: RequestMethod = .post
    public var path: String = "/common/oauth2/logout"
    let body: Data?

    public init() {
        body = nil
    }
}
