//
//  File.swift
//  
//
//  Created by Alexander Tooszovski on 07.07.2020.
//

import Foundation

protocol HSERequest {
    associatedtype ResponseResult: Decodable
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

