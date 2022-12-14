//
//  CategoryTagsCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

protocol CategoryTagsCollectionViewCellDelegate: AnyObject {
    func didTapCategoryButton(cell: UICollectionViewCell)
}

class CategoryTagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagButton: UIButton!
    
    weak var delegate: CategoryTagsCollectionViewCellDelegate?
    
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
        tagButton.titleLabel?.numberOfLines = 1
        tagButton.tintColor = .white
        tagButton.backgroundColor = UIColor(red: 73 / 255, green: 0 / 255, blue: 119 / 255, alpha: 1)
        tagButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
    
    func setupTagsButtons(model: TagsResponse) {
        tagButton.setTitle(model.display_name, for: .normal)
    }
    
    @IBAction func categoryTapped(_ sender: Any) {
        delegate?.didTapCategoryButton(cell: self)
    }
}
