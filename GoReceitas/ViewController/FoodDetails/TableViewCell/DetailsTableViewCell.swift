//
//  DetailsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 16/11/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let identifier = "DetailsTableViewCell"
    
    lazy var proteinsContainer: PurpleFadedView = {
        let view = PurpleFadedView(labelText: "Proteins")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var fatContainer: PurpleFadedView = {
        let view = PurpleFadedView(labelText: "Fat")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var caloriesContainer: PurpleFadedView = {
        let view = PurpleFadedView(labelText: "Calories")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var carbContainer: PurpleFadedView = {
        let view = PurpleFadedView(labelText: "Carb")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configure(nutritions: Nutrition) {
        if let proteins = nutritions.protein,
           let fat = nutritions.fat,
           let calories = nutritions.calories,
           let carb = nutritions.carbohydrates {
            proteinsContainer.setNumber(of: String(proteins))
            fatContainer.setNumber(of: String(fat))
            caloriesContainer.setNumber(of: String(calories))
            carbContainer.setNumber(of: String(carb))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .viewBackgroundColor
        
        contentView.addSubview(proteinsContainer)
        contentView.addSubview(fatContainer)
        contentView.addSubview(caloriesContainer)
        contentView.addSubview(carbContainer)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            proteinsContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            proteinsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            fatContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            fatContainer.leadingAnchor.constraint(equalTo: proteinsContainer.trailingAnchor, constant: 10),
            
            caloriesContainer.topAnchor.constraint(equalTo: proteinsContainer.bottomAnchor, constant: 10),
            caloriesContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            carbContainer.topAnchor.constraint(equalTo: fatContainer.bottomAnchor, constant: 10),
            carbContainer.leadingAnchor.constraint(equalTo: caloriesContainer.trailingAnchor, constant: 10),
        ])
    }
}
