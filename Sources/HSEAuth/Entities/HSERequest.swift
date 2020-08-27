import Foundation

protocol HSERequest {
    associatedtype ResponseResult: Decodable
    var host: String? { get }
    var method: RequestMethod { get }
    var path: String { get }
    var body: Data? { get }
}

public enum RequestMethod: String {
    case get
    case post
    case put
    case delete

    var string: String {
        return self.rawValue.uppercased()
    }
}

