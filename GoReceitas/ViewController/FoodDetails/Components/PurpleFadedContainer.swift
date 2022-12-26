//
//  purpleFadedContainer.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import Foundation
import UIKit

class PurpleFadedView: UIButton {
    
    //MARK: - Initializer
    private lazy var insideContainer = PurpleInsideView()
    
    init(labelText: String) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 185/255, green: 142/255, blue: 255/255, alpha: 0.9)
        setTitle(labelText, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel?.textAlignment = .center
        titleLabel?.baselineAdjustment = .alignBaselines
        layer.cornerRadius = 6
        layer.shadowRadius = .greatestFiniteMagnitude
        
        self.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.widthAnchor.constraint(equalToConstant: 175).isActive = true
        
        setInsideContainer()
    }
    
    private func setInsideContainer() {
        insideContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(insideContainer)
        
        insideContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        insideContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
    
    func setNumber(of nutrients: String) {
        insideContainer.setNumber(of: nutrients)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
