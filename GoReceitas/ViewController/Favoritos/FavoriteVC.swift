//
//  FavoriteVC.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 05/10/22.
//

import UIKit

class FavoriteVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var favorites: [CellsInfoSections] = [
//        .init(foodName: "Macarrão", prepTime: "60min", foodImage: "macarrao"),
//        .init(foodName: "Lasanha", prepTime: "40min", foodImage: "lasanha"),
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        collectionView.backgroundColor = .viewBackgroundColor
        configCollectionView()
    }
    
    func configCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.sectionInset = .init(top: 0, left: 17, bottom: 0, right: 17)
                    layout.estimatedItemSize = .zero
                    layout.minimumInteritemSpacing = 0
        
                  
                }
        collectionView.register(DefaultFoodCollectionViewCell.nib(), forCellWithReuseIdentifier: DefaultFoodCollectionViewCell.identifier)
        collectionView.register(NoFavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: NoFavoritesCollectionViewCell.identifier)
    }
}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
//        return !favorites.isEmpty ? favorites.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if favorites.isEmpty {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoFavoritesCollectionViewCell.identifier, for: indexPath) as? NoFavoritesCollectionViewCell
//            return cell ?? UICollectionViewCell()
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultFoodCollectionViewCell.identifier, for: indexPath) as? DefaultFoodCollectionViewCell
//        cell?.setup(font: 15, weight: .bold)
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return !favorites.isEmpty ?
//        CGSize(width: self.view.frame.size.width / 2.3, height: 150) :
//        CGSize(width: 230, height: 280)
        return CGSize(width: self.view.frame.size.width / 2.3, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = FoodDetailsViewController()
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FavoriteVC: DefaultFoodCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        print("index", indexPath.row, #function)
    }
}
