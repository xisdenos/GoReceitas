//
//  FoodDetailsCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 01/11/22.
//

import UIKit

class FoodDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    @IBOutlet weak var foodImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier: String = "FoodDetailsCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(_ foodInfo: CellsInfoSections) {
        self.foodImg.image = UIImage(named: foodInfo.foodImage)
        self.foodNameLbl.text = foodInfo.foodName
        self.prepTimeLbl.text = foodInfo.prepTime
    }

}
