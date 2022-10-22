//
//  FavoriteCollectionViewCell.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 21/10/22.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    
    // mesmo nome do arquivo é nome da classe que é nome do identificador (o mesmo nome pros tres)
    static let identifier: String = "FavoriteCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.layer.cornerRadius = 10.0
        foodImageView.layer.masksToBounds = true
        foodLabel.layer.cornerRadius = 5.0
        foodLabel.layer.masksToBounds = true
        prepTimeLabel.layer.cornerRadius = 10.0
        prepTimeLabel.layer.masksToBounds = true
        
    }
    //Tentei seguir a mesma lógica da cel da home mas n deu certo
//    func setup(_ foodInfo: CellsInfoSections) {
//        self.foodImageView.image = UIImage(named: foodInfo.foodImage ?? "")
//        self.foodLabel.text = foodInfo.foodName
//        self.prepTimeLabel.text = foodInfo.prepTime
//    }
    
    func setupCell(nameImage: String){
        foodImageView.image = UIImage(named: nameImage)
    }
    
}
