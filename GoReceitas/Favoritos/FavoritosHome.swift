//
//  FavoritosHome.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 28/08/22.
//

import UIKit

class FavoritosHome: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(FavoritosCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritosCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

}
extension FavoritosHome: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
    }
}

extension FavoritosHome: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritosCollectionViewCell.identifier, for: indexPath) as? FavoritosCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
}

extension FavoritosHome: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2.3, height: 150)
    }
}
