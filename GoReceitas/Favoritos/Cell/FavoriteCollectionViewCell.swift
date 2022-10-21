//
//  FavoriteCollectionViewCell.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 21/10/22.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    
    // mesmo nome do arquivo é nome da classe que é nome do identificador (o mesmo nome pros tres)
    static let identifier: String = "FavoriteCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foodImageView.contentMode = .scaleAspectFill
    }

    func setupCell(nameImage: String){
        foodImageView.image = UIImage(named: nameImage)
    }
    
}
