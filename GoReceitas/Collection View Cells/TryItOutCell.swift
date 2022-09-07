//
//  TryItOutCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/09/22.
//

import UIKit

class TryItOutCell: UICollectionViewCell {
    static let identifier = String(describing: TryItOutCell.self)
    
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    
    func setup(_ foodInfo: CellsInfoSections) {
        self.foodImg.image = UIImage(named: foodInfo.foodImage ?? "")
        self.foodNameLbl.text = foodInfo.foodName
        self.prepTimeLbl.text = foodInfo.prepTime
    }
}
