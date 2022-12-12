//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    private var service: Service = Service()

    public var foodData: [FoodResponse] = []
    
    private var currentDataSource: [FoodResponse] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSearchBar: UIView!
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Food name..."
        search.searchBar.searchBarStyle = .minimal
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        currentDataSource = foodData
        
        tableView.backgroundColor = .viewBackgroundColor
        self.view.backgroundColor = .viewBackgroundColor
        
        containerSearchBar.addSubview(searchController.searchBar)
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResultsTableViewCell.nib(), forCellReuseIdentifier: ResultsTableViewCell.identifier)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
        cell.setup(currentDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let food = currentDataSource[indexPath.row]
        
        print(food)
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
        service.getMoreInfo(id: food.id) { details in
            switch details {
            case .success(let success):
                DispatchQueue.main.async {
                    viewController.configureFoodInformation(foodDetails: success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        if searchText.count >= 3 {
            service.searchFoodWith(term: searchText) { [weak self] foodsResult in
                switch foodsResult {
                case .success(let foods):
                    self?.currentDataSource = foods.results
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
        if searchText.count == 0 {
            currentDataSource = foodData
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentDataSource = foodData
        tableView.reloadData()
    }
}
