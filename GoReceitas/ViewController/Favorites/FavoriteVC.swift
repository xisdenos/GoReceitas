//
//  FavoriteVC.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 05/10/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol FavoritesUpdateDelegate: AnyObject {
    func favoritesUpdated()
}

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var service: Service = Service()
    
    private var alert: AlertController?
    
    private var favorites: [FoodResponse] = [FoodResponse]()
    private var isFavorited: Bool = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    let database = Database.database().reference()
    
    weak var delegate: DefaultCellsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        collectionView.backgroundColor = .viewBackgroundColor
        configCollectionView()
        populateArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func populateArray() {
        let ref = Database.database().reference()
        let userEmail = Favorite.getCurrentUserEmail
        
        ref.child("users/\(userEmail)/favorites").observe(.value) { snapshot in
            if snapshot.hasChildren() {
                if let dictionary = snapshot.value as? [String: Any] {
                    // in order to overwrite the array, first we need to remove all items then set it again
                    // otherwise the array will be doubled
                    self.favorites.removeAll()
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
                            let foodPrepTime = details["prep_time_minutes"] as! Int
                            
                            let recipe = FoodResponse(id: foodId, name: foodName, thumbnail_url: foodImage, cook_time_minutes: foodCookTime, prep_time_minutes: foodPrepTime, yields: foodYields)
                            
                            self.favorites.append(recipe)
                        }
                    }
                }
            } else {
                self.favorites.removeAll()
            }
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
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
        
//        collectionView.register(DefaultFoodCollectionViewCell.nib(), forCellWithReuseIdentifier: DefaultFoodCollectionViewCell.identifier)
        collectionView.register(FavoriteCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        collectionView.register(NoFavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: NoFavoritesCollectionViewCell.identifier)
    }
}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !favorites.isEmpty ? favorites.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if favorites.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoFavoritesCollectionViewCell.identifier, for: indexPath) as? NoFavoritesCollectionViewCell
            cell?.isUserInteractionEnabled = false
            return cell ?? UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell
        cell?.setup(model: favorites[indexPath.row])
        cell?.delegate = self
        cell?.viewController = self
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return !favorites.isEmpty ?
        CGSize(width: self.view.frame.size.width / 2.3, height: 150) :
        CGSize(width: 230, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FoodDetailsViewController()
        let foodSelected = favorites[indexPath.row]
        controller.foodId = foodSelected.id
        navigationController?.pushViewController(controller, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            controller.activityIndicator.startAnimating()
            controller.foodDetailsView.tableView.isHidden = true
            controller.foodDetailsView.topFadedLabel.isHidden = true
            controller.foodDetailsView.purpheHearthView.isHidden = true
            controller.foodDetailsView.timeView.isHidden = true
            self?.service.getMoreInfo(id: foodSelected.id) { details in
                switch details {
                case .success(let success):
                    controller.configureFoodInformation(foodDetails: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
            self?.service.getSimilarFoods(id: foodSelected.id, completion: { result in
                switch result {
                case .success(let success):
                    controller.configureRecommendedFoods(foods: success.results)
                case .failure(let failure):
                    print(failure)
                }
            })
        }
    }
}

extension FavoriteVC: DefaultFoodCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        guard let foodIndexPath = collectionView.indexPath(for: cell) else { return }
        let food = favorites[foodIndexPath.row]
        Favorite.unfavoriteItem(at: food, database: self.database)
        favorites.remove(at: foodIndexPath.row)
        collectionView.reloadData()
    }
}

