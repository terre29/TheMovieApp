//
//  GenreCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Indocyber on 11/09/23.
//

import Foundation
import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var genre: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundCell.backgroundColor = .systemGray5
            } else {
                backgroundCell.backgroundColor = .clear
            }
        }
    }
    
    
    
    func setupCell() {
        backgroundCell.clipsToBounds = true
        backgroundCell.layer.cornerRadius = backgroundCell.frame.size.height/2
        backgroundCell.layer.borderColor = UIColor.systemGray3.cgColor
        backgroundCell.layer.borderWidth = 1
    }
    
}
