//
//  MovieDetailProtocol.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation
import UIKit

protocol MovieDetailPresenterToView {
    var presenter: MovieDetailViewToPresenter? { get set }
    
    func updateMovieDetail(movieDetail: MovieDetailViewModel)
    func updateReview(review: [ReviewViewModel])
    
    func showError(error: Error)
    
}

protocol MovieDetailViewToPresenter {
    var view: MovieDetailPresenterToView? { get set }
    var router: MovieDetailPresenterToRouter? { get set }
    

    func fetchMovieVideo(movieId: Int)
    func fetchMovieDetail(movieId: Int)
    func fetchReview(movieId: Int, page: Int)
}

protocol MovieDetailPresenterToInteractor {
    var presenter: MovieDetailInteractorToPresenter? { get set }
    
    func getMovieDetail(movieId: Int)
    func getReviews(movieId: Int, page: Int)
    func getMovieVideo(movieId: Int)
    
}

protocol MovieDetailPresenterToRouter {
    var viewController: UIViewController? { get set }
    func navigateToYoutubeVideo(id: String)
}

protocol MovieDetailInteractorToPresenter {
    var interactor: MovieDetailPresenterToInteractor? { get set }
    
    func displayMovieDetail(movieDetail: MovieDetailViewModel, error: Error?)
    func displayReview(review: [ReviewViewModel], error: Error?)
    func displayMovieVideos(videos: [MovieVideoViewModel], error: Error?)
    
}
