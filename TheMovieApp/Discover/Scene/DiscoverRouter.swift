//
//  DiscoverRouter.swift
//  TheMovieApp
//
//  Created by Indocyber on 11/09/23.
//

import Foundation
import UIKit

class DiscoverRouter: DiscoverPresenterToRouter {
    
    var viewController: UIViewController?
    
    func navigateToMovieDetail(movieId: Int) {
        let destinationVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "movieDetail") as! MovieDetailViewController
        destinationVC.movieId = movieId
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
     
}
