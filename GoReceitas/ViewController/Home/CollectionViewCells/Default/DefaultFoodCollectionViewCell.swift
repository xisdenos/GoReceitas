//
//  DefaultFoodCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class DefaultFoodCollectionViewCell: UICollectionViewCell {
    // containers
    @IBOutlet weak var favoriteButtonContainer: UIView!
    @IBOutlet weak var foodNameContainer: UIView!
    @IBOutlet weak var additionalInfoContainer: UIView!
    
    // elements
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    static let identifier: String = String(describing: DefaultFoodCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .viewBackgroundColor
        configVisualElements()
        mockInfo()
    }
    
    func configVisualElements() {
        foodNameContainer.cornerRadius = 5
        favoriteButtonContainer.cornerRadius = 5
        additionalInfoContainer.cornerRadius = 5
        foodImageView.cornerRadius = 5
        
        foodImageView.contentMode = .scaleAspectFill
        foodName.textColor = .white
        additionalInfoLabel.textColor = .white
        foodName.textAlignment = .center
    }
    
    func mockInfo() {
        additionalInfoLabel.text = "Yields 5 portions"
        foodName.text = "Croissant Breakfast"
        foodImageView.image = UIImage(named: "croissant-breakfast-pizza")
//        UIFont.systemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>)
    }
    
    func setup(font size: CGFloat, weight: UIFont.Weight) {
        foodName.font = .systemFont(ofSize: size, weight: weight)
    }
}