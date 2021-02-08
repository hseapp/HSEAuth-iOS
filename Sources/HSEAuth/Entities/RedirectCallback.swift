import Foundation

public struct RedirectCallback {
    public let scheme: String
    public let host: String
    public let path: String
    
    public init(scheme: String, host: String, path: String) {
        self.scheme = scheme
        self.host = host
        self.path = path
    }
    
    public func redirectString() -> String {
        scheme + "://" + host + path
    }
}
