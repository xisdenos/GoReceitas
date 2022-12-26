//
//  TimeView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import UIKit

class TimerView: UIView {
    
    lazy var prepTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "35 min"
        label.textColor = UIColor(white: 1, alpha: 0.87)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(height: CGFloat = 35, width: CGFloat = 100) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 161/255, green: 156/255, blue: 163/255, alpha: 0.7)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
//        self.cornerRadius = 10
        
        setPrepTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(with text: String) {
        prepTimeLabel.text = text
    }
    
    func setPrepTimeLabel() {
        addSubview(prepTimeLabel)
        
        prepTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        prepTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
