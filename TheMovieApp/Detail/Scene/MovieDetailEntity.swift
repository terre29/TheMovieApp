//
//  MovieDetailEntity.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation

struct MovieVideoViewModel {
    let type: String
    let key: String
    let id: String
}

struct MovieVideoAPIResponseModel: Codable {
    let id: Int
    let results: [MovieVideoModel]
}

struct MovieVideoModel: Codable {
    let type: String
    let key: String
    let id: String
}

struct MovieDetailViewModel {
    let title: String
    let overview: String
    let imageURL: String
    let backdropURL: String
    let rating: Double
    let duration: Int
    let genres: [String]
}

struct MovieDetailAPIResponseModel: Codable {
    let backdropPath: String
    let title: String
    let genres: [MovieDetailGenres]
    let runtime: Int
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case title
        case genres
        case runtime
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.backdropPath, forKey: .backdropPath)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.genres, forKey: .genres)
        try container.encode(self.runtime, forKey: .runtime)
        try container.encode(self.overview, forKey: .overview)
        try container.encode(self.posterPath, forKey: .posterPath)
        try container.encode(self.voteAverage, forKey: .voteAverage)
        try container.encode(self.voteCount, forKey: .voteCount)
    }
}

struct MovieDetailGenres: Codable {
    let id: Int
    let name: String
}

struct ReviewViewModel {
    let author: String
    let review: String
}

struct ReviewAPIResponseModel: Codable {
    let page: Int
    let results: [ReviewModel]
}

struct ReviewModel: Codable {
    let author: String
    let content: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(String.self, forKey: .author)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    enum CodingKeys: String, CodingKey {
        case author
        case content
    }
    
}
