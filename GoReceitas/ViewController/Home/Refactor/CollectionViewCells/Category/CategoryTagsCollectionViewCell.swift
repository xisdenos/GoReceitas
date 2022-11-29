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
        self.backgroundColor = .viewBackgroundColor
        configTagsButtons()
    }
    
    func configTagsButtons() {
        tagButton.layer.borderWidth = 1
        tagButton.layer.cornerRadius = 10
        tagButton.tintColor = .white
//        tagButton.setTitleColor(.white, for: .normal)
        tagButton.backgroundColor = UIColor(red: 73 / 255, green: 0 / 255, blue: 119 / 255, alpha: 1)
        tagButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
}
