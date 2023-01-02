//
//  RecommendedFoodsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 16/11/22.
//

import UIKit
import FirebaseDatabase

class RecommendedFoodsTableViewCell: UITableViewCell {
    static let identifier: String = "RecommendedFoodsTableViewCell"
    private var recommendedFoods: [FoodResponse] = [FoodResponse]()
    
    weak var delegate: DefaultCellsDelegate?
    
    private var favoriteKeys: [String] = [String]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    let database = Database.database().reference()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .viewBackgroundColor
        collection.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
        
        return collection
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        checkFavoriteStatusAndUpdate()
        self.backgroundColor = .viewBackgroundColor
    }
    
    func hasFavorites(food: FoodResponse) -> Bool {
        if favoriteKeys.contains(String(food.id)) {
            return true
        } else {
            return false
        }
    }
    
    func checkFavoriteStatusAndUpdate() {
        let userEmail = Favorite.getCurrentUserEmail
        
        database.child("users/\(userEmail)").child("favorites").observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                self.favoriteKeys.removeAll()
                for (key, _) in dictionary {
                    self.favoriteKeys.append(key)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    func setup(foods: [FoodResponse]) {
        self.recommendedFoods = foods
    }
}

extension RecommendedFoodsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedFoods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.identifier, for: indexPath) as? FoodCollectionViewCell
        
        let isFavorited = hasFavorites(food: recommendedFoods[indexPath.row])
        cell?.configure(food: recommendedFoods[indexPath.row], isFavorited: isFavorited)
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapDefaultFoodCell(food: recommendedFoods[indexPath.row])
    }
}

extension RecommendedFoodsTableViewCell: PurpleHeartViewProtocol {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let foodSelected = recommendedFoods[indexPath.row]
        let foodId = String(foodSelected.id)
        let userEmail = Favorite.getCurrentUserEmail
        
        database.child("users/\(userEmail)").child("favorites").observeSingleEvent(of: .value) { snapshot in
            if snapshot.hasChild(foodId) {
                Favorite.unfavoriteItem(at: foodSelected, database: self.database)
            } else {
                self.delegate?.didFavoriteItem(itemSelected: foodSelected, favorited: isActive)
            }
        }
    }
}
