//
//  ResponseSession.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/27/24.
//

import Foundation

struct SessionResponse: Codable {
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
