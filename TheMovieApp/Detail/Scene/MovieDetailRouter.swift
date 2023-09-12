//
//  MovieDetailRouter.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation
import UIKit

class MovieDetailRouter: MovieDetailPresenterToRouter {
    var viewController: UIViewController?
    
    func navigateToYoutubeVideo(id: String) {
        var youtubeUrl = URL(string:"youtube://\(id)")!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        } else{
            youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(id)")! as URL
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
    }
    
    
}
