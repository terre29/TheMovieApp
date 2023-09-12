//
//  DiscoverPresenter.swift
//  TheMovieApp
//
//  Created by Indocyber on 10/09/23.
//

import Foundation

class DiscoverPresenter: DiscoverViewToPresenter, DiscoverInteractorToPresenter {
    
    var router: DiscoverPresenterToRouter?
    var interactor: DiscoverPresenterToInteractor?
    var view: DiscoverPresenterToView?
    
    func fetchMovie(genre: String, page: Int) {
        interactor?.getMovie(genre: genre, page: page)
        view?.showLoading()
    }
    
    func fetchGenre() {
        interactor?.getGenre()
    }
    
    func goToMovieDetail(movieId: Int) {
        router?.navigateToMovieDetail(movieId: movieId)
    }
    
    func displayMovieList(movieList: [DiscoverMovieViewModel], error: Error?) {
        if let error = error {
            view?.showError(error: error)
        } else {
            view?.updateMovie(movies: movieList)
        }
        view?.dismissLoading()
    }
    
    func displayGenreList(genreList: [GenreViewModel], error: Error?) {
        if let error = error {
            view?.showError(error: error)
        } else {
            view?.updateGenre(genres: genreList)
        }
        
    }
    
}
