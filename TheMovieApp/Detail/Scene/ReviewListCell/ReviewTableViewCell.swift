//
//  ReviewTableViewCell.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation
import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var reviewBackgroundView: UIView!
    
    
    func setupCell(reviewViewModel: ReviewViewModel) {
        authorName.text = reviewViewModel.author
        let dateFormatter = DateFormatter()
        content.text = reviewViewModel.review
    }
    
    
}
