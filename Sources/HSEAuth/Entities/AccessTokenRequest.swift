//
//  File.swift
//  
//
//  Created by Alexander Tooszovski on 07.07.2020.
//

import Foundation

public struct AccessTokenRequest: HSERequest {
    public typealias ResponseResult = AccessTokenResponse
    var method: RequestMethod = .post
    public var path: String = "/adfs/oauth2/token/"
    let body: Data?

    public init(code: String, clientId: String) {
        body = URLComponents()
            .add(key: "code", value: code)
            .add(key: "redirect_uri", value: "ru.hse.pf://auth.hse.ru/adfs/oauth2/ios/ru.hse.pf/callback")
            .add(key: "client_id", value: clientId)
            .add(key: "grant_type", value: "authorization_code")
            .percentEncodedQuery?
            .data(using: .utf8)
    }
}


