//
//  DescriptionTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 16/11/22.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    static let identifier: String = "DescriptionTableViewCell"
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        • Pasta
        1 cup of wheat flour
        1 beaten yolk
        100 grams of unsalted butter
        2 tablespoons of sugar
        1 tablespoon of baking powder

        • Filling
        700 milliliters of milk
        """
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(instructionsLabel)
        self.backgroundColor = .viewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        instructionsLabel.frame = bounds
    }
}
