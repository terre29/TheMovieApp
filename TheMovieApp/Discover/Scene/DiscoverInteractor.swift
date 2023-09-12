//
//  DiscoverViewInteractor.swift
//  TheMovieApp
//
//  Created by Terretino on 10/09/23.
//

import Foundation
import Moya

class DiscoverViewInteractor: DiscoverPresenterToInteractor {
    
    var presenter: DiscoverInteractorToPresenter?

    let moyaProvider = MoyaProvider<DiscoverApiTarget>()
    
    func getMovie(genre: String, page: Int) {
        moyaProvider.request(.getMovieList(genre: genre, page: page), completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(DiscoverAPIResponseModel.self)
                    let viewModel = response.results.map({
                        return DiscoverMovieViewModel(movieId: $0.id, movieTitle: $0.originalTitle, movieDescription: $0.overview, movieImageURL: "https://image.tmdb.org/t/p/w500"+$0.posterPath)
                    })
                    presenter?.displayMovieList(movieList: viewModel, error: nil)
                } catch let error {
                    presenter?.displayMovieList(movieList: [], error: error)
                }
            case .failure(let error):
                presenter?.displayMovieList(movieList: [], error: error)
            }
        })
    }
    
    func getGenre() {
        moyaProvider.request(.getGenre, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let response = try response.map(GenreAPIResponseModel.self)
                    let viewModel = response.genres.map({
                        return GenreViewModel(genre: $0.name, id: $0.id)
                    })
                    presenter?.displayGenreList(genreList: viewModel, error: nil)
                } catch let error {
                    presenter?.displayMovieList(movieList: [], error: error)
                }
            case .failure(let error):
                presenter?.displayMovieList(movieList: [], error: error)
            }
        })
    }
    
    
}
