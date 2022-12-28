//
//  FavoriteVC.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 05/10/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var favorites: [FoodResponse] = [FoodResponse]()
    
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        collectionView.backgroundColor = .viewBackgroundColor
        configCollectionView()
        populateArray()
    }
    
    
    func populateArray() {
        let ref = Database.database().reference()
        if let user = Auth.auth().currentUser {
            guard let email = user.email else { return }
            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
            
            
            ref.child("users/\(emailFormatted)/favorites").observeSingleEvent(of: .value) { snapshot  in
                if let dictionary = snapshot.value as? [String: Any] {
                    // Iterate over the dictionary of recipes
                    for item in dictionary {
                        // get the values: ex "Easy Chocolate Rugelach" = { "name": "Easy Chocolate Rugelach" }
                        let favoriteItem = item.value as! [String: Any]
                        
                        // iterate once again so we can get the inner dictionary values: ex { "name": "Easy Chocolate Rugelach" }
                        for foodInfo in favoriteItem {
                            let details = foodInfo.value as! NSDictionary
                            
                            let foodName = details["name"] as! String
                            let foodYields = details["yields"] as! String
                            let foodCookTime = details["cook_time_minutes"] as! Int
                            let foodId = details["id"] as! Int
                            let foodImage = details["image"] as! String
                            let isFavorited = details["isFavorited"] as! Int
                            let foodPrepTime = details["prep_time_minutes"] as! Int
                            
                            let recipe = FoodResponse(id: foodId, name: foodName, thumbnail_url: foodImage, cook_time_minutes: foodCookTime, prep_time_minutes: foodPrepTime, yields: foodYields)
                            
                            self.favorites.append(recipe)
//                            print(self.favorites)
//                            print(self.favorites.count)
                            
//                            print("TERMINOU 1")
                        }
//                        print("TERMINOU 2")
                    }
//                    print("TERMINOU 3")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                print("TERMINOU 4")
            }
        }
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
        return favorites.count
        //  return !favorites.isEmpty ? favorites.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if favorites.isEmpty {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoFavoritesCollectionViewCell.identifier, for: indexPath) as? NoFavoritesCollectionViewCell
        //            return cell ?? UICollectionViewCell()
        //        }
        
        if !favorites.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultFoodCollectionViewCell.identifier, for: indexPath) as? DefaultFoodCollectionViewCell
            cell?.setupTryItOut(model: favorites[indexPath.row])
            cell?.delegate = self
            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
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
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        //        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        //        print("index", indexPath.row, #function)
    }
}
