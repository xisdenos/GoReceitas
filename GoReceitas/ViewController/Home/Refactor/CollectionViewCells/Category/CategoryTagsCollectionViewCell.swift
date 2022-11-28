//
//  CategoryTagsCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class CategoryTagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagButton: UIButton!
    
    static let identifier: String = String(describing: CategoryTagsCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagButton.layer.borderWidth = 1
        tagButton.layer.cornerRadius = 5
        tagButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
}
