//
//  FavoritosCollectionViewCell.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 28/08/22.
//

import UIKit

class FavoritosCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier : String = "FavoritosCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
