//
//  DiscoverProtocol.swift
//  TheMovieApp
//
//  Created by Indocyber on 10/09/23.
//

import Foundation
import UIKit

protocol DiscoverPresenterToView {
    var presenter: DiscoverViewToPresenter? { get set }
    
    func updateMovie(movies: [DiscoverMovieViewModel])
    func updateGenre(genres: [GenreViewModel])
    
    func showError(error: Error)
    
    func showLoading()
    func dismissLoading()
}

protocol DiscoverViewToPresenter {
    var view: DiscoverPresenterToView? { get set }
    var router: DiscoverPresenterToRouter? { get set }
    func fetchMovie(genre: String, page: Int)
    func fetchGenre()
    func goToMovieDetail(movieId: Int) 
}

protocol DiscoverPresenterToInteractor {
    var presenter: DiscoverInteractorToPresenter? { get set }
    
    func getMovie(genre: String, page: Int)
    func getGenre() 
}

protocol DiscoverPresenterToRouter {
    var viewController: UIViewController? { get set }
    func navigateToMovieDetail(movieId: Int)
}


protocol DiscoverInteractorToPresenter {
    var interactor: DiscoverPresenterToInteractor? { get set }
    
    func displayMovieList(movieList: [DiscoverMovieViewModel], error: Error?)
    func displayGenreList(genreList: [GenreViewModel], error: Error?)
}
