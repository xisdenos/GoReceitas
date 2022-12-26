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
    private var favoritesArray: [FoodResponse] = [FoodResponse]()
    
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
            // está mockado!
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
    func didTapHeartButton(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let foodSelected = foodList[indexPath.row]
        favoritesArray.append(foodSelected)
        print(foodSelected)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let user = Auth.auth().currentUser {
                let database = Database.database().reference()
                guard let email = user.email else { return }
//                let data = [["name": foodSelected.name, "image": foodSelected.thumbnail_url, "yields": foodSelected.yields ?? "n/a"]]
                let mappedArray = self?.favoritesArray.map { ["name": $0.name, "yields": $0.yields, "image": $0.thumbnail_url] }
                let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                database.child("users/\(emailFormatted)").child("favorites").setValue(mappedArray)
            } else {
                print("There is no currently signed-in user.")
            }
        }
    }
}

/*
 let id: Int
 let name: String
 let thumbnail_url: String
 let cook_time_minutes, prep_time_minutes: Int?
 // rendimento
 let yields: String?
 */
