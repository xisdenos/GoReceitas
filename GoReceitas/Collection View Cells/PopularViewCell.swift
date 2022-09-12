//
//  PopularViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/09/22.
//

import UIKit

class PopularViewCell: UICollectionViewCell {
    // cell identifier = "PopularViewCell"
    static let identifier = String(describing: PopularViewCell.self)
    private var isActive: Bool = false
    
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    
    func setup(_ foodInfo: CellsInfoSections) {
        self.foodImg.image = UIImage(named: foodInfo.foodImage ?? "")
        self.foodNameLbl.text = foodInfo.foodName
        self.prepTimeLbl.text = foodInfo.prepTime
    }
    
    
    @IBAction func heartButton(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }
    
    private func toggleHeartImage(for button: UIButton) {
        if isActive == false {
            button.setImage(UIImage(named: "heart-fill"), for: .normal)
            isActive = true
        } else if isActive == true {
            button.setImage(UIImage(named: "heart-empty"), for: .normal)
            isActive = false
        }
    }
}
