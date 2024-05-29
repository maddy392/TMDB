//
//  PostSession.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/27/24.
//

import Foundation

struct PostSession: Codable {
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}
