//
//  MovieModel.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/26/24.
//

import Foundation

struct Movie: Codable, Equatable {
    
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let posterPath: String?
    let popularity: Double
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
