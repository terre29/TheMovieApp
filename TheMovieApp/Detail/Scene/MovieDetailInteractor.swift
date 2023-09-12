//
//  MovieDetailInteractor.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation
import Moya

class MovieDetailInteractor: MovieDetailPresenterToInteractor {
   
    
    var presenter: MovieDetailInteractorToPresenter?
    
    let moyaProvider = MoyaProvider<MovieDetailAPITarget>()
    
    func getMovieDetail(movieId: Int) {
        moyaProvider.request(.movieDetail(movieId: movieId), completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(MovieDetailAPIResponseModel.self)
                    let viewModel = MovieDetailViewModel(title: response.title, overview: response.overview, imageURL: "https://image.tmdb.org/t/p/w500"+response.posterPath, backdropURL: "https://image.tmdb.org/t/p/w500"+response.backdropPath, rating: response.voteAverage, duration: response.runtime, genres: response.genres.map{$0.name})
                    presenter?.displayMovieDetail(movieDetail: viewModel, error: nil)
                } catch let error {
                    presenter?.displayMovieDetail(movieDetail: MovieDetailViewModel(title: "", overview: "", imageURL: "", backdropURL: "", rating: 0, duration: 0, genres: []), error: error)
                }
            case .failure(let error):
                presenter?.displayMovieDetail(movieDetail: MovieDetailViewModel(title: "", overview: "", imageURL: "", backdropURL: "", rating: 0, duration: 0, genres: []), error: error)
            }
        })
    }
    
    func getReviews(movieId: Int, page: Int) {
        moyaProvider.request(.review(movieId: movieId, page: page), completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(ReviewAPIResponseModel.self)
                    let viewModel = response.results.map({
                        ReviewViewModel(author: $0.author, review: $0.content)
                    })
                    presenter?.displayReview(review: viewModel, error: nil)
                } catch let error {
                    presenter?.displayReview(review: [], error: error)
                }
            case .failure(let error):
                presenter?.displayReview(review: [], error: error)
            }
        })
    }
    
    func getMovieVideo(movieId: Int) {
        moyaProvider.request(.youtubeVideo(movieId: movieId), completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(MovieVideoAPIResponseModel.self)
                    let viewModel = response.results.map({
                        MovieVideoViewModel(type: $0.type, key: $0.key, id: $0.id)
                    })
                    presenter?.displayMovieVideos(videos: viewModel, error: nil)
                } catch let error {
                    presenter?.displayMovieVideos(videos: [], error: error)
                }
            case .failure(let error):
                presenter?.displayMovieVideos(videos: [], error: error)
            }
        })
    }
    
}
