//
//  File.swift
//  
//
//  Created by Alexander Tooszovski on 07.07.2020.
//

import Foundation

public struct AccessTokenResponse: Codable {
    let scope: String
    let accessToken: String
    let resource: String
    let tokenType: String
    let idToken: String
    let expiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int

    enum CodingKeys: String, CodingKey {
        case scope, resource
        case accessToken = "access_token"
        case tokenType = "token_type"
        case idToken = "id_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
    }
}
