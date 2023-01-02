//
//  purpleHearthView.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 01/11/22.
//

import UIKit

protocol PurpleHeartViewProtocol: AnyObject {
    func didTapHeartButton(isActive: Bool)
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool)
}

extension PurpleHeartViewProtocol {
    func didTapHeartButton(isActive: Bool) {}
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {}
}

class PurpleHeart: UIView {
    
    private var isActive: Bool = false
    
    lazy var hearthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart-empty"), for: .normal)

        return button
    }()
    
    weak var delegate: PurpleHeartViewProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor(red: 250/255, green: 236/255, blue: 255/255, alpha: 1)
        layer.cornerRadius = 10
        configButton()
    }
    
    func configButton() {
        addSubview(hearthButton)
        hearthButton.addTarget(self, action: #selector(tappedHeart), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            hearthButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hearthButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc func tappedHeart() {
        isActive = !isActive
        if isActive == true {
            hearthButton.setImage(UIImage(named: "heart-empty"), for: .normal)
            print(isActive)
            delegate?.didTapHeartButton(isActive: isActive)
        } else if isActive == false {
            hearthButton.setImage(UIImage(named: "heart-fill"), for: .normal)
            delegate?.didTapHeartButton(isActive: isActive)
            print(isActive)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
