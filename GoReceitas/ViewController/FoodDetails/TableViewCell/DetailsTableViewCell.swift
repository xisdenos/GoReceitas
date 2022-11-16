//
//  DetailsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 16/11/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let identifier = "DetailsTableViewCell"
    
    lazy var firstPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Proteins", numberText: "25")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Fat", numberText: "81")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thirdPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Calories", numberText: "105")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var forthPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Carb", numberText: "53")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .viewBackgroundColor
        
        contentView.addSubview(firstPurpleContainer)
        contentView.addSubview(secondPurpleContainer)
        contentView.addSubview(thirdPurpleContainer)
        contentView.addSubview(forthPurpleContainer)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            firstPurpleContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            firstPurpleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            secondPurpleContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            secondPurpleContainer.leadingAnchor.constraint(equalTo: firstPurpleContainer.trailingAnchor, constant: 10),
            
            thirdPurpleContainer.topAnchor.constraint(equalTo: firstPurpleContainer.bottomAnchor, constant: 10),
            thirdPurpleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            forthPurpleContainer.topAnchor.constraint(equalTo: secondPurpleContainer.bottomAnchor, constant: 10),
            forthPurpleContainer.leadingAnchor.constraint(equalTo: thirdPurpleContainer.trailingAnchor, constant: 10),
        ])
    }
}
