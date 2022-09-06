//
//  CategoryCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/09/22.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryViewCell.self)
    
    @IBOutlet weak var categoryButton: UIButton!
    
    func setup(_ tagInfo: CategoryModel) {
        self.categoryButton.setTitle(tagInfo.categoryName, for: .normal)
    }
}
