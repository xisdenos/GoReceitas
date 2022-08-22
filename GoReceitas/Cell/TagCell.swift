//
//  TagCell.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 22/08/22.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    static let identifier = "TagCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var tagView: UIView!
    
}
