//
//  EmptySearchTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 15/01/23.
//

import UIKit

class EmptySearchTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: EmptySearchTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var noResultsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(message: String) {
        noResultsLabel.text = message
    }

}
