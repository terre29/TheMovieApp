//
//  MovieDetailWorker.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation
import Moya

enum MovieDetailAPITarget {
    case movieDetail(movieId: Int)
    case review(movieId: Int, page: Int)
    case youtubeVideo(movieId: Int)
}

extension MovieDetailAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .movieDetail(let movieId):
            return "/movie/\(movieId)"
            
        case .review(let movieId, _):
            return "/movie/\(movieId)/reviews"
        case .youtubeVideo(let movieId):
            return "movie/\(movieId)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movieDetail:
            return .get
            
        case .review:
            return .get
            
        case .youtubeVideo:
            return .get
        }
    }
    
    var task: Moya.Task{
        switch self {
        case .movieDetail:
            return .requestPlain
        case .review(_, let page):
            let parameters: [String: Any] = ["language": "en-US", "page": page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .youtubeVideo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MjRmMzk4ODMxYThmMjJmYWU3MWFmYjQ4NjE4YTU1ZSIsInN1YiI6IjYzOWFjYTY4OTg4YWZkMDBhN2FhMDU5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.am1bd_vCXDmlJ_SgGksl0HrE9dvSGnJFAY9GYXKZmh0"
        ]
    }
}
