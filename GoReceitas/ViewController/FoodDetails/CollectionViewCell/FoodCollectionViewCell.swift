//
//  FoodCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 16/11/22.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: FoodCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = .green
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var purpheHearthView: purpleHearth = {
        let view = purpleHearth()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topFadedLabel: UIButton = {
        let view = NextScreenGreenButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setConstraints() {
        contentView.addSubview(purpheHearthView)
        contentView.addSubview(topFadedLabel)
        
        NSLayoutConstraint.activate([
            
            purpheHearthView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            purpheHearthView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            purpheHearthView.heightAnchor.constraint(equalToConstant: 40),
            purpheHearthView.widthAnchor.constraint(equalToConstant: 40),
            
            topFadedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            topFadedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            topFadedLabel.trailingAnchor.constraint(equalTo: purpheHearthView.leadingAnchor, constant:  -5),
            topFadedLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    
    
}
