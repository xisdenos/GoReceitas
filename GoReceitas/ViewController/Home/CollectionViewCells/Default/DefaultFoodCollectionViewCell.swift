//
//  DefaultFoodCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

protocol DefaultFoodCollectionViewCellDelegate: AnyObject {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool)
}

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
    
    weak var delegate: DefaultFoodCollectionViewCellDelegate?
    
    private var isActive: Bool = false
    
    static let identifier: String = String(describing: DefaultFoodCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .viewBackgroundColor
        configVisualElements()
    }
    
    func configVisualElements() {
        foodNameContainer.layer.cornerRadius = 5
        favoriteButtonContainer.layer.cornerRadius = 5
        additionalInfoContainer.layer.cornerRadius = 5
        foodImageView.layer.cornerRadius = 5
        
        foodImageView.contentMode = .scaleAspectFill
        foodName.textColor = .white
        additionalInfoLabel.textColor = .white
        foodName.textAlignment = .center
    }
    
    func setup(model: FoodResponse, isFavorited: Bool = false) {
        foodName.text = model.name
        additionalInfoLabel.text = model.yields ?? ""
        foodImageView.loadImageUsingCache(withUrl: model.thumbnail_url)
        isFavorited == true ? favoriteButton.setImage(UIImage(named: "heart-fill"), for: .normal) : favoriteButton.setImage(UIImage(named: "heart-empty"), for: .normal)
        foodName.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    @IBAction func heartFavoriteTapped(_ sender: UIButton) {
        isActive = !isActive
        print("heart tapped default", #function)
        if isActive {
            sender.setImage(UIImage(named: "heart-fill"), for: .normal)
            delegate?.didTapHeartButton(cell: self, isActive: isActive)
        } else {
            delegate?.didTapHeartButton(cell: self, isActive: isActive)
            sender.setImage(UIImage(named: "heart-empty"), for: .normal)
        }
    }
}
