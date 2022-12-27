//
//  PopularFoodsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

protocol PopularFoodsTableViewCellDelegate: AnyObject {
    func didTapFoodCell(food: PopularResponseDetails)
}

class PopularFoodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var popularList: [PopularResponseDetails] = [PopularResponseDetails]()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    weak var delegate: PopularFoodsTableViewCellDelegate?
    
    static let identifier: String = String(describing: PopularFoodsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = .viewBackgroundColor
        configCollectionView()
        setActivityIndicator()
    }
    
    func setActivityIndicator() {
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DefaultFoodCollectionViewCell.nib(), forCellWithReuseIdentifier: DefaultFoodCollectionViewCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
    
    public func configure(with model: [PopularResponseDetails]) {
        self.popularList = model.shuffled()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension PopularFoodsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultFoodCollectionViewCell.identifier, for: indexPath) as? DefaultFoodCollectionViewCell {
            if !popularList.isEmpty {
                cell.setupPopular(model: popularList[indexPath.row])
            }
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapFoodCell(food: popularList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.2, height: 140)
    }
}

extension PopularFoodsTableViewCell: DefaultFoodCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        
    }
    
//    func didTapHeartButton(cell: UICollectionViewCell) {
//        guard let indexPath = collectionView.indexPath(for: cell) else { return }
//        print("index", indexPath.row, #function)
//    }
}
