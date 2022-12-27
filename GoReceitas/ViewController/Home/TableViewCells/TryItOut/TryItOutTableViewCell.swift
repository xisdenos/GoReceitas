//
//  TryItOutTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol TryItOutTableViewCellDelegate: AnyObject {
    func didFavoriteItem(index: IndexPath)
}

class TryItOutTableViewCell: UITableViewCell {
    private var foodList: [FoodResponse] = [FoodResponse]()
    private var favoritesArray: [[String : Any]] = [[:]]
    
    let auth = Auth.auth()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: DefaultCellsDelegate?
    
    static let identifier: String = String(describing: TryItOutTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .viewBackgroundColor
        selectionStyle = .none
        configCollectionView()
        populateArray()
    }
    
    func populateArray() {
        if let user = Auth.auth().currentUser {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let database = Database.database().reference()
                guard let email = user.email else { return }
                let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                database.child("users/\(emailFormatted)").child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get the data from the snapshot and assign it to favorites array
                    if let data = snapshot.value as? [[String : Any]] {
                        self?.favoritesArray = data
                    }
                })
            }
        } else {
            print("There is no currently signed-in user.")
        }
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DefaultFoodCollectionViewCell.nib(), forCellWithReuseIdentifier: DefaultFoodCollectionViewCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = .init(top: 10, left: 5, bottom: 0, right: 5)
        }
    }
    
    public func configure(with model: [FoodResponse]) {
        self.foodList = model
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension TryItOutTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultFoodCollectionViewCell.identifier, for: indexPath) as? DefaultFoodCollectionViewCell {
            
            if !foodList.isEmpty {
                cell.setupTryItOut(model: foodList[indexPath.row])
            }
            
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapFoodCell(food: foodList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if foodList.count > 10 {
            return 10
        }
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 5, height: collectionView.frame.height - 10)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        pageControl.currentPage = visibleIndexPath?.row ?? 1
    }
}

extension TryItOutTableViewCell: DefaultFoodCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let foodSelected = foodList[indexPath.row]
        
        if let user = Auth.auth().currentUser {
            DispatchQueue.global(qos: .userInitiated).async {
                let database = Database.database().reference()
                guard let email = user.email else { return }
                let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

                let favArray: [FoodResponse] = [FoodResponse(id: foodSelected.id, name: foodSelected.name, thumbnail_url: foodSelected.thumbnail_url, cook_time_minutes: foodSelected.cook_time_minutes ?? 0, prep_time_minutes: foodSelected.prep_time_minutes ?? 0, yields: foodSelected.yields ?? "n/a")]

                let mappedArray = favArray.map { ["name": $0.name, "yields": $0.yields ?? "n/a", "image": $0.thumbnail_url, "isFavorited": isActive] }

                // so we can track the array of favorites and update the values correctly
                self.favoritesArray.append(contentsOf: mappedArray)

                database.child("users/\(emailFormatted)").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild("favorites") {

                        let updates = ["users/\(emailFormatted)/favorites": self.favoritesArray]
                        database.updateChildValues(updates as [AnyHashable : Any])

                        print("The value already exists in the database.")
                    } else {
                        database.child("users/\(emailFormatted)").child("favorites").setValue(mappedArray)
                        print("The value does not exist in the database.")
                    }
                })
            }
        } else {
            print("There is no currently signed-in user.")
        }
    }
}
