//
//  ResultsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 26/10/22.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var prepTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier: String = "ResultsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(_ cellInfo: CellsInfoSections) {
        foodName.text = cellInfo.foodName
        prepTime.text = cellInfo.prepTime
        foodImage.image = UIImage(named: cellInfo.foodImage ?? "")
        foodImage.contentMode = .scaleAspectFill
        foodImage.layer.cornerRadius = 10
        foodImage.layer.masksToBounds = true
    }
}
