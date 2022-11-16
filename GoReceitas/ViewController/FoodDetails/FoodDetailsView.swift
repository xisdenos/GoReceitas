//
//  FoodDetailsView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

class FoodDetailsView: UIView {
    
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .viewBackgroundColor
        table.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        table.register(RecommendedFoodsTableViewCell.self, forCellReuseIdentifier: RecommendedFoodsTableViewCell.identifier)
        return table
    }()
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mac-and-cheese")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(foodImageView)

        foodImageView.addSubview(topFadedLabel)
        foodImageView.addSubview(purpheHearthView)
        foodImageView.addSubview(timeView)

        self.addSubview(detailLabel)
        self.addSubview(firstPurpleContainer)
        self.addSubview(secondPurpleContainer)
        self.addSubview(thirdPurpleContainer)
        self.addSubview(forthPurpleContainer)
        
        self.addSubview(tableView)

        configConstraints()
        self.backgroundColor = .viewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var topFadedLabel: UIButton = {
        let view = NextScreenGreenButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var purpheHearthView: purpleHearth = {
        let view = purpleHearth()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeView: TimerView = {
        let timer = TimerView(height: 35, width: 100)
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detalhes"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
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
    
    lazy var prepareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients:"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    //MARK: Constraints
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            foodImageView.topAnchor.constraint(equalTo: self.topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 350),
            
            topFadedLabel.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 60),
            topFadedLabel.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: 20),
            topFadedLabel.trailingAnchor.constraint(equalTo: purpheHearthView.leadingAnchor, constant: -15),

            purpheHearthView.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 50),
            purpheHearthView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -20),
            purpheHearthView.widthAnchor.constraint(equalToConstant: 50),
            purpheHearthView.heightAnchor.constraint(equalToConstant: 50),

            timeView.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: -20),
            timeView.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: 10),
            
            detailLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 5),
            detailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            firstPurpleContainer.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            firstPurpleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            secondPurpleContainer.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            secondPurpleContainer.leadingAnchor.constraint(equalTo: firstPurpleContainer.trailingAnchor, constant: 10),

            thirdPurpleContainer.topAnchor.constraint(equalTo: firstPurpleContainer.bottomAnchor, constant: 10),
            thirdPurpleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            forthPurpleContainer.topAnchor.constraint(equalTo: secondPurpleContainer.bottomAnchor, constant: 10),
            forthPurpleContainer.leadingAnchor.constraint(equalTo: thirdPurpleContainer.trailingAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: forthPurpleContainer.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
