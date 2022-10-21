//
//  FavoriteVC.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 05/10/22.
//

import UIKit

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [String] = ["bbq", "breakfast", "healthy", "indian", "italian"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    func configCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
        collectionView.register(FavoriteCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
    }
    
}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell
        cell?.setupCell(nameImage: data[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
}
