//
//  DiscoverEntity.swift
//  TheMovieApp
//
//  Created by Indocyber on 11/09/23.
//

import Foundation

struct DiscoverMovieViewModel {
    let movieId: Int
    let movieTitle: String
    let movieDescription: String
    let movieImageURL: String
}

struct GenreViewModel {
    let genre: String
    let id: Int
}

struct GenreAPIResponseModel: Codable {
    let genres: [GenreResponse]
}

struct GenreResponse: Codable {
    let id: Int
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}

struct DiscoverAPIResponseModel: Codable {
    let page: Int
    let results: [DiscoverResponse]
}

struct DiscoverResponse: Codable {
    let id: Int
    let originalTitle: String
    let posterPath: String
    let voteAverage: Double
    let overview: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.overview = try container.decode(String.self, forKey: .overview)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "title"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case overview = "overview"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(overview, forKey: .overview)
    }
    
}
