//
//  ViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 19/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tagCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configCollectionView() {
        tagCollection.delegate = self
        tagCollection.dataSource = self
        tagCollection.register(TagCell.nib(), forCellWithReuseIdentifier: TagCell.identifier)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.tagCollection.frame.width / 2.3 , height: 50)
    }
}
