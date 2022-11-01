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
    
    @IBOutlet weak var heartButton: UIButton!
    
    private var isActive: Bool = false
    
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
        foodImage.image = UIImage(named: cellInfo.foodImage)
        foodImage.contentMode = .scaleAspectFill
        foodImage.layer.cornerRadius = 10
        foodImage.layer.masksToBounds = true
    }
    
    @IBAction func heartTapped(_ sender: UIButton) {
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
