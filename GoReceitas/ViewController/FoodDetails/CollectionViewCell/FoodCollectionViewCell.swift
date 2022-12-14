//
//  FoodCollectionViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 16/11/22.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: FoodCollectionViewCell.self)
    
    private var isActive: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = .green
        setConstraints()
    }
    
    weak var delegate: PurpleHeartViewProtocol?
    
    public func configure(food: FoodResponse, isFavorited: Bool = false) {
        topFadedLabel.setTitle(food.name, for: .normal)
        timerView.setTitle(with: food.yields ?? "N/A")
        foodImageView.loadImageUsingCache(withUrl: food.thumbnail_url)
        isFavorited == true ? purpheHearthView.hearthButton.setImage(UIImage(named: "heart-fill"), for: .normal) : purpheHearthView.hearthButton.setImage(UIImage(named: "heart-empty"), for: .normal)
    }
    
    @objc private func toggleHeartImage() {
        isActive = !isActive
        delegate?.didTapHeartButton(cell: self, isActive: isActive)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var purpheHearthView: PurpleHeart = {
        let view = PurpleHeart()
        view.hearthButton.addTarget(self, action: #selector(toggleHeartImage), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topFadedLabel: UIButton = {
        let view = NextScreenGreenButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timerView: TimerView = {
        let timer = TimerView(height: 30, width: 160)
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mac-and-cheese")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func setConstraints() {
        contentView.addSubview(foodImageView)
        foodImageView.addSubview(purpheHearthView)
        foodImageView.addSubview(topFadedLabel)
        foodImageView.addSubview(timerView)
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            purpheHearthView.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 5),
            purpheHearthView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -5),
            purpheHearthView.heightAnchor.constraint(equalToConstant: 40),
            purpheHearthView.widthAnchor.constraint(equalToConstant: 40),
            
            topFadedLabel.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 5),
            topFadedLabel.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: 5),
            topFadedLabel.trailingAnchor.constraint(equalTo: purpheHearthView.leadingAnchor, constant:  -5),
            topFadedLabel.heightAnchor.constraint(equalToConstant: 40),
            
            timerView.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: -5),
        ])
    }
}
