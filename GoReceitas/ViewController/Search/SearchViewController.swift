//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UIViewController {
    
    private var userTyped: Bool = false
    
    private var service: Service = Service()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    weak var delegate: DefaultCellsDelegate?
    
    let database = Database.database().reference()
    
    var model: NetworkModel = NetworkModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSearchBar: UIView!
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsController())
        search.searchBar.placeholder = "Food name..."
        search.searchBar.searchBarStyle = .minimal
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.isTranslucent = false
        search.searchBar.barTintColor = .viewBackgroundColor
        // corrige search bar sobrepondo a navigation da proxima tela quando disparada
        // https://stackoverflow.com/a/42392069
        search.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        return search
    }()
//    let resultController = searchController.searchResultsController as! SearchResultsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        tableView.backgroundColor = .viewBackgroundColor
        self.view.backgroundColor = .viewBackgroundColor
        
        navigationItem.searchController = searchController
        setActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

extension SearchViewController: DefaultCellsDelegate {
    func didTapDefaultFoodCell(food: FoodResponse) {
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            viewController.activityIndicator.startAnimating()
            viewController.foodDetailsView.tableView.isHidden = true
            viewController.foodDetailsView.topFadedLabel.isHidden = true
            viewController.foodDetailsView.purpheHearthView.isHidden = true
            viewController.foodDetailsView.timeView.isHidden = true
            self?.service.getMoreInfo(id: food.id) { details in
                switch details {
                case .success(let success):
                    viewController.configureFoodInformation(foodDetails: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
            self?.service.getSimilarFoods(id: food.id, completion: { result in
                switch result {
                case .success(let success):
                    viewController.configureRecommendedFoods(foods: success.results)
                    
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            })
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let resultController = searchController.searchResultsController as! SearchResultsController
        resultController.delegate = self
        
        guard let searchText = searchController.searchBar.text,
        !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
        searchText.trimmingCharacters(in: .whitespaces).count >= 3 else {
            // if text is less than 3, clean the array
            // this is useful because it takes both cases when user tap cancel
            // and X button to clear search bar text.
            resultController.foodResult.removeAll()
            DispatchQueue.main.async {
                resultController.tableView.reloadData()
            }
            return
        }

        model.search(text: searchText) { result in
            DispatchQueue.main.async {
                resultController.activityIndicator.startAnimating()
            }
            switch result {
            case .success(let foods):
                resultController.foodResult = foods.results
                DispatchQueue.main.async {
                    resultController.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}


extension SearchViewController: DefaultTableViewCellDelegate {
    func didTapHeartButton(cell: UITableViewCell, isActive: Bool) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        let foodSelected = currentDataSource[indexPath.row]
//        let foodId = String(foodSelected.id)
//        let userEmail = Favorite.getCurrentUserEmail
//
//        database.child("users/\(userEmail)").child("favorites").observeSingleEvent(of: .value) { snapshot in
//            if snapshot.hasChild(foodId) {
//                Favorite.unfavoriteItem(at: foodSelected, database: self.database)
//            } else {
//                self.delegate?.didFavoriteItem(itemSelected: foodSelected, favorited: isActive)
//            }
//        }
    }
}
