//
//  DiscoverNetwork.swift
//  TheMovieApp
//
//  Created by Indocyber on 10/09/23.
//

import Foundation
import Moya

enum DiscoverApiTarget {
    case getGenre
    case getMovieList(genre: String, page: Int)
}

extension DiscoverApiTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getGenre:
            return "/genre/movie/list"
            
        case .getMovieList:
            return "/discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGenre:
            return .get
            
        case .getMovieList:
            return .get
        }
    }
    
    var task: Moya.Task{
        switch self {
        case .getGenre:
            return .requestPlain
        case .getMovieList(let genre, let page):
            let parameters: [String: Any] = ["with_genres": genre == "0" ? "" : genre, "page": page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MjRmMzk4ODMxYThmMjJmYWU3MWFmYjQ4NjE4YTU1ZSIsInN1YiI6IjYzOWFjYTY4OTg4YWZkMDBhN2FhMDU5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.am1bd_vCXDmlJ_SgGksl0HrE9dvSGnJFAY9GYXKZmh0"
        ]
    }
    
}
