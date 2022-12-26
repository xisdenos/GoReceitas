//
//  PurpleInsideView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import UIKit

class PurpleInsideView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 150/255, green: 86/255, blue: 255/255, alpha: 1)
        layer.cornerRadius = 8
        
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        setLabel()
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setLabel() {
        addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setNumber(of nutrients: String) {
        label.text = nutrients
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
