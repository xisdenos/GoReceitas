//
//  NoFavoritesCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 01/11/22.
//

import UIKit

class NoFavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noFavoritesImageView: UIImageView!
    @IBOutlet weak var noFavoritesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier: String = "NoFavoritesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

