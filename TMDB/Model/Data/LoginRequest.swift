//
//  LoginRequest.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/27/24.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case requestToken = "request_token"
    }
}
