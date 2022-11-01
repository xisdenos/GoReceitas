//
//  FoodDetailsView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

class FoodDetailsView: UIView {
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mac-and-cheese")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
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
        let timer = TimerView()
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    lazy var pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 250/255, green: 236/255, blue: 255/255, alpha: 1)
        return view
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detalhes"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var firstPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Proteínas", numberText: "25")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Gorduras", numberText: "81")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thirdPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Calorias", numberText: "105")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var forthPurpleContainer: purpleFadedView = {
        let view = purpleFadedView(labelText: "Sais", numberText: "53")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var prepareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Modo de Preparo:"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Em um recipiente, coloque a farinha e faça um buraco no meio. Em seguida, acrescente 1 gema batida, 100 gramas de manteiga. Em um recipiente, coloque a farinha e faça um buraco no meio. Em seguida, acrescente 1 gema batida, 100 gramas de manteiga sem sal, 2 colheres de sopa de açúcar e 1 colher de sopa de fermento em pó. Misture até obter uma massa homogênea e lisa."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(foodImageView)
        addSubview(topFadedLabel)
        addSubview(purpheHearthView)
        addSubview(timeView)
        addSubview(pinkView)
        addSubview(detailLabel)
        addSubview(firstPurpleContainer)
        addSubview(secondPurpleContainer)
        addSubview(thirdPurpleContainer)
        addSubview(forthPurpleContainer)
        addSubview(prepareLabel)
        addSubview(instructionsLabel)
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Constraints
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            foodImageView.topAnchor.constraint(equalTo: self.topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 350),
            
            topFadedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            topFadedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            purpheHearthView.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            purpheHearthView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            purpheHearthView.widthAnchor.constraint(equalToConstant: 50),
            purpheHearthView.heightAnchor.constraint(equalToConstant: 50),
            
            timeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 290),
            timeView.leadingAnchor.constraint(equalTo: topFadedLabel.leadingAnchor),
            
            pinkView.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 1),
            pinkView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pinkView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pinkView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            detailLabel.topAnchor.constraint(equalTo: pinkView.topAnchor, constant: 5),
            detailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            firstPurpleContainer.topAnchor.constraint(equalTo: pinkView.topAnchor, constant: 60),
            firstPurpleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            secondPurpleContainer.topAnchor.constraint(equalTo: pinkView.topAnchor, constant: 60),
            secondPurpleContainer.leadingAnchor.constraint(equalTo: firstPurpleContainer.trailingAnchor, constant: 15),
            
            thirdPurpleContainer.topAnchor.constraint(equalTo: firstPurpleContainer.bottomAnchor, constant: 30),
            thirdPurpleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            forthPurpleContainer.topAnchor.constraint(equalTo: secondPurpleContainer.bottomAnchor, constant: 30),
            forthPurpleContainer.leadingAnchor.constraint(equalTo: thirdPurpleContainer.trailingAnchor, constant: 15),
            
            prepareLabel.topAnchor.constraint(equalTo: thirdPurpleContainer.bottomAnchor, constant: 25),
            prepareLabel.leadingAnchor.constraint(equalTo: firstPurpleContainer.leadingAnchor),
            
            instructionsLabel.topAnchor.constraint(equalTo: prepareLabel.bottomAnchor,constant: 8),
            instructionsLabel.leadingAnchor.constraint(equalTo: prepareLabel.leadingAnchor),
            instructionsLabel.trailingAnchor.constraint(equalTo: secondPurpleContainer.trailingAnchor)
        ])
    }
}
