//
//  FavoriteVC.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 05/10/22.
//

import UIKit

class FavoriteVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [CellsInfoSections] = [
        .init(foodName: "Macarrão", prepTime: "60min", foodImage: "macarrao"),
        .init(foodName: "Lasanha", prepTime: "40min", foodImage: "lasanha"),
    ]
    
    
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
        collectionView.register(FavoriteCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        collectionView.register(NoFavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: NoFavoritesCollectionViewCell.identifier)
    }
}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !data.isEmpty ? data.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if data.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoFavoritesCollectionViewCell.identifier, for: indexPath) as? NoFavoritesCollectionViewCell
            return cell ?? UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell
        cell?.setupCell(foodinfo: data[indexPath.row])
        cell?.viewController = self
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return !data.isEmpty ?
        CGSize(width: self.view.frame.size.width / 2.3, height: 150) :
        CGSize(width: 230, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FavoriteVC: FavoriteCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        data.remove(at: indexPath.row)
        collectionView.reloadData()
    }
}
