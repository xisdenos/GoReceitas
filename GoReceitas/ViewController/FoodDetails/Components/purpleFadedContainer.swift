//
//  purpleFadedContainer.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import Foundation
import UIKit

class purpleFadedView: UIButton {
    
    //MARK: - Initializer
    
    init(labelText: String, numberText: String) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 185/255, green: 142/255, blue: 255/255, alpha: 0.9)
        setTitle(labelText, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel?.textAlignment = .center
        titleLabel?.baselineAdjustment = .alignBaselines
        layer.cornerRadius = 6
        layer.shadowRadius = .greatestFiniteMagnitude
        
        let insideConteiner = PurpleInsideView(initialNumber: numberText)
        insideConteiner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(insideConteiner)
        
        self.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.widthAnchor.constraint(equalToConstant: 175).isActive = true
        insideConteiner.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        insideConteiner.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
