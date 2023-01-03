//
//  PopularFoodsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PopularFoodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var popularList: [FoodResponse] = [FoodResponse]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var favoriteKeys: [String] = [String]()
    
    let database = Database.database().reference()
    
    weak var delegate: DefaultCellsDelegate?
    
    static let identifier: String = String(describing: PopularFoodsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = .viewBackgroundColor
        configCollectionView()
        checkFavoriteStatusAndUpdate()
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated(_:)), name: .favoritesUpdated, object: nil)
    }
    
    @objc func favoritesUpdated(_ notification: Notification) {
        // Get the additional information from the notification's userInfo property
        if let userInfo = notification.userInfo {
            // Use the information as needed
            let foodID = userInfo.values.first as! String
            if let index = favoriteKeys.firstIndex(of: foodID) {
                favoriteKeys.remove(at: index)
            }
        }
    }
    
    func hasFavorites(food: FoodResponse) -> Bool {
        if favoriteKeys.contains(String(food.id)) {
            return true
        } else {
            return false
        }
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
    
    public func configure(with model: [FoodResponse]) {
        DispatchQueue.main.async { [weak self] in
            self?.popularList = model.shuffled()
        }
    }
}

extension PopularFoodsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultFoodCollectionViewCell.identifier, for: indexPath) as? DefaultFoodCollectionViewCell {
            
            let isFavorited = hasFavorites(food: popularList[indexPath.row])
            cell.setup(model: popularList[indexPath.row], isFavorited: isFavorited)
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapDefaultFoodCell(food: popularList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if popularList.count > 8 {
            return 8
        }
        return popularList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.2, height: 140)
    }
}

extension PopularFoodsTableViewCell: DefaultFoodCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let foodSelected = popularList[indexPath.row]
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
