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
    
    weak var delegate: DefaultTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier: String = "ResultsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(_ cellInfo: FoodResponse, isFavorited: Bool = false) {
        foodName.text = cellInfo.name
        prepTime.text = cellInfo.yields ?? "N/A"
        foodImage.loadImageUsingCache(withUrl: cellInfo.thumbnail_url)
        foodImage.contentMode = .scaleAspectFill
        foodImage.layer.cornerRadius = 10
        foodImage.layer.masksToBounds = true
        heartButton.layer.cornerRadius = 10
        heartButton.clipsToBounds = true
        isFavorited == true ? heartButton.setImage(UIImage(named: "heart-fill"), for: .normal) : heartButton.setImage(UIImage(named: "heart-empty"), for: .normal)
    }
    
    @IBAction func heartTapped(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }
    
    private func toggleHeartImage(for button: UIButton) {
        isActive = !isActive
        if isActive == true {
            button.setImage(UIImage(named: "heart-fill"), for: .normal)
            delegate?.didTapHeartButton(cell: self, isActive: isActive)
        } else if isActive == false {
            button.setImage(UIImage(named: "heart-empty"), for: .normal)
            delegate?.didTapHeartButton(cell: self, isActive: isActive)
        }
    }
}
