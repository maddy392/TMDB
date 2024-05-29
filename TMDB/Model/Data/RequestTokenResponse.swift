//
//  RequestTokenResponse.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/27/24.
//

import Foundation

struct RequestTokenResponse: Codable {
    let success: Bool
    let expirationTime: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expirationTime = "expires_at"
        case requestToken = "request_token"
    }
}
