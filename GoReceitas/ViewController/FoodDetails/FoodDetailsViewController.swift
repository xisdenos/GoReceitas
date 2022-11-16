//
//  FoodDetailsViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    
    lazy var foodDetailsView: FoodDetailsView = {
        let foodview = FoodDetailsView()
        foodview.collectionView.delegate = self
        foodview.collectionView.dataSource = self
        return foodview
    }()
    
    override func loadView() {
        super.loadView()
        view = foodDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension FoodDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.identifier, for: indexPath) as? FoodCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 190)
    }
    
}
