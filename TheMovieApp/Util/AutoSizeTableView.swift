//
//  AutoSizeTableView.swift
//  TheMovieApp
//
//  Created by Indocyber on 12/09/23.
//

import Foundation
import UIKit

public class AutoSizeTableview: UITableView {

    override public var intrinsicContentSize: CGSize {

        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override public var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override public func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
}
