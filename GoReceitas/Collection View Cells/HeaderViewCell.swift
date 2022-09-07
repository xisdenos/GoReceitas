//
//  HeaderViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 07/09/22.
//


import UIKit


class HeaderViewCell: UICollectionReusableView {
    static let identifier = String(describing: HeaderViewCell.self)
    
    @IBOutlet weak var headerTitle: UILabel!
    
    func setup(_ title: String) {
        self.headerTitle.text = title
    }
}
