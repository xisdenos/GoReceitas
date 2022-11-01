//
//  TimeView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import UIKit

class TimerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 161/255, green: 156/255, blue: 163/255, alpha: 0.7)
        self.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.cornerRadius = 10
        
        let label = UILabel()
        label.text = "20 min"
        label.textColor = UIColor(white: 1, alpha: 0.87)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "pencil.circle")
        addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
