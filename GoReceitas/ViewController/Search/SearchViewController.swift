//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit
import FirebaseDatabase

//protocol SearchViewControllerProtocol: AnyObject {
//    func startLoading()
//    func stopLoading()
//}

class SearchViewController: UIViewController {
    
    public var foodData: [FoodResponse] = []
    
    private var service: Service = Service()
    private var currentDataSource: [FoodResponse] = []
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
//    weak var delegate: SearchViewControllerProtocol?
    weak var delegate: DefaultCellsDelegate?
    
    let database = Database.database().reference()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSearchBar: UIView!
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsController())
        search.searchBar.placeholder = "Food name..."
        search.searchBar.searchBarStyle = .minimal
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        // corrige search bar sobrepondo a navigation da proxima tela quando disparada
        // https://stackoverflow.com/a/42392069
        search.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        currentDataSource = foodData
//        delegate = self
        
        tableView.backgroundColor = .viewBackgroundColor
        self.view.backgroundColor = .viewBackgroundColor
        
        containerSearchBar.addSubview(searchController.searchBar)
        configTableView()
        setActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResultsTableViewCell.nib(), forCellReuseIdentifier: ResultsTableViewCell.identifier)
    }
    
    func setActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
        if !currentDataSource.isEmpty {
            cell.setup(currentDataSource[indexPath.row])
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let food = currentDataSource[indexPath.row]
        
        print(food)
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
//        guard let searchText = searchController.searchBar.text else { return }
//
//        if searchText.count >= 3 {
//            self.delegate?.startLoading()
//            service.searchFoodWith(term: searchText) { [weak self] foodsResult in
//                switch foodsResult {
//                case .success(let foods):
//                    self?.currentDataSource = foods.results
//                    self?.delegate?.stopLoading()
//                case .failure(let failure):
//                    self?.delegate?.stopLoading()
//                    print(failure)
//                }
//            }
//        }
//
//        if searchText.count == 0 {
//            currentDataSource = foodData
//            tableView.reloadData()
//        }
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        currentDataSource = foodData
//        tableView.reloadData()
//    }
}

//extension SearchViewController: SearchViewControllerProtocol {
//    func startLoading() {
//        DispatchQueue.main.async { [weak self] in
//            self?.tableView.isHidden = true
//            self?.activityIndicator.startAnimating()
//        }
//    }
//
//    func stopLoading() {
//        DispatchQueue.main.async { [weak self] in
//            self?.tableView.reloadData()
//            self?.tableView.isHidden = false
//            self?.activityIndicator.stopAnimating()
//        }
//    }
//}

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
