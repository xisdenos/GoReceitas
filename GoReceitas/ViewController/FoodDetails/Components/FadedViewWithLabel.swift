//
//  FadedViewWithLabel.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

class NextScreenGreenButton: UIButton {
    
    //MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 161/255, green: 156/255, blue: 163/255, alpha: 0.7)
        setTitle("Mac-And-Cheese", for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 6
        layer.shadowRadius = .greatestFiniteMagnitude
        
        self.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        self.heightAnchor.constraint(equalToConstant: height).isActive = true
//        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

