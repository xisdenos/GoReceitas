//
//  CategoryTagsTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class CategoryTagsTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: CategoryTagsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .viewBackgroundColor
        configCollectionView()
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryTagsCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryTagsCollectionViewCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = .init(top: 10, left: 10, bottom: 5, right: 10)
        }
    }
}

extension CategoryTagsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTagsCollectionViewCell.identifier, for: indexPath) as? CategoryTagsCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
}
