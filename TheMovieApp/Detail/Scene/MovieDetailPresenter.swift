//
//  MovieDetailPresenter.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation

class MovieDetailPresenter: MovieDetailViewToPresenter, MovieDetailInteractorToPresenter {
  
    var view: MovieDetailPresenterToView?
    var router: MovieDetailPresenterToRouter?
    var interactor: MovieDetailPresenterToInteractor?
    
    func fetchMovieDetail(movieId: Int) {
        interactor?.getMovieDetail(movieId: movieId)
    }
    
    func fetchReview(movieId: Int, page: Int) {
        interactor?.getReviews(movieId: movieId, page: page)
    }
    
    func displayMovieDetail(movieDetail: MovieDetailViewModel, error: Error?) {
        if let error = error {
            view?.showError(error: error)
        } else {
            view?.updateMovieDetail(movieDetail: movieDetail)
        }
        
    }
    
    func displayReview(review: [ReviewViewModel], error: Error?) {
        if let error = error {
            view?.showError(error: error)
        } else {
            view?.updateReview(review: review)
        }
        
    }
    
    func goToYoutube(id: String) {
        router?.navigateToYoutubeVideo(id: id)
    }
    
    func fetchMovieVideo(movieId: Int) {
        interactor?.getMovieVideo(movieId: movieId)
    }
    
    func displayMovieVideos(videos: [MovieVideoViewModel], error: Error?) {
        if let error = error {
            view?.showError(error: error)
        } else {
            let video = videos.first(where: {$0.type == "Teaser" || $0.type == "Trailer"})
            goToYoutube(id: video!.key)
        }
        
    }
    
}
