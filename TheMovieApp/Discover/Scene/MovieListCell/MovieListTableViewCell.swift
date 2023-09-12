//
//  MovieListTableViewCell.swift
//  TheMovieApp
//
//  Created by Indocyber on 11/09/23.
//

import Foundation
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var backgroundCell: UIView!
    
    func initSetupCell() {
        moviePoster.clipsToBounds = true
        backgroundCell.layer.cornerRadius = 12
        backgroundCell.backgroundColor = .systemGray5
    }
    
    override func prepareForReuse() {
        movieTitle.text = ""
        movieDescription.text = ""
    }
    
    func setupCell(viewModel: DiscoverMovieViewModel) {
        movieTitle.text = viewModel.movieTitle
        movieDescription.text = viewModel.movieDescription
       
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        moviePoster.kf.setImage(with: URL(string: viewModel.movieImageURL), options: [.processor(processor)], completionHandler: { result in
            result.map({ result in
                DispatchQueue.main.async {
                    self.moviePoster.image = result.image
                }
            })
        })
    }
    
}
