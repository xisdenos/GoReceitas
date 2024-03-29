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
    private var searchTimer: Timer?
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
        viewController.foodId = food.id
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
    
    func didFavoriteItem(itemSelected: FoodResponse, favorited: Bool) {
        Favorite.favoriteItem(itemSelected: itemSelected, favorited: favorited, database: database)
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
        
        DispatchQueue.main.async {
            resultController.activityIndicator.startAnimating()
            resultController.tableView.isHidden = true
        }
        
        // Invalidate any existing timer
        searchTimer?.invalidate()
        
        // Start a new timer with a 2.0 second delay
        searchTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
            // Perform the search with the current text in the search bar
            self?.model.search(text: searchText) { result in
                switch result {
                case .success(let foods):
                    resultController.state = .normal
                    resultController.foodResult = foods
                    DispatchQueue.main.async {
                        resultController.tableView.isHidden = false
                        resultController.tableView.reloadData()
                    }
                case .failure(let failure):
                    // first we pass the text forward to show exacly where the user is wrong
                    resultController.searchText = searchText
                    // then we update the state to show the correct cell
                    resultController.state = .noResults
                    DispatchQueue.main.async {
                        // show table view
                        resultController.tableView.isHidden = false
                        // if a search is well succeded and right away we fail, we need to empty the
                        // success array so we can show properly the empty state; otherwise
                        // it would just keep showing the populated food cell even though our result failed.
                        resultController.foodResult.removeAll()
                        resultController.activityIndicator.stopAnimating()
                        resultController.tableView.reloadData()
                    }
                    print("FAILURE,", failure)
                }
            }
        }
    }
}
