//
//  purpleHearthView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import UIKit

class purpleHearth: UIView {
    
    lazy var hearthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart-empty-fav"), for: .normal)
        
        return button
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor(red: 250/255, green: 236/255, blue: 255/255, alpha: 1)
        layer.cornerRadius = 10
        addSubview(hearthButton)
        
        hearthButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hearthButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
