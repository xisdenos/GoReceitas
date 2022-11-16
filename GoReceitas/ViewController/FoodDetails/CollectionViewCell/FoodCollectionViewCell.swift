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
    
    func setConstraints() {
        contentView.addSubview(purpheHearthView)
        
        NSLayoutConstraint.activate([
            
            purpheHearthView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            purpheHearthView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            purpheHearthView.heightAnchor.constraint(equalToConstant: 40),
            purpheHearthView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
