//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit

class SearchViewController: UIViewController {

    public var foodData: [CellsInfoSections] = [
        .init(foodName: "Birria tacos", prepTime: "35 min", foodImage: "birria-tacos"),
        .init(foodName: "Potato tacos", prepTime: "20 min", foodImage: "potato-tacos"),
        .init(foodName: "Salad", prepTime: "15 min", foodImage: "salad"),
        .init(foodName: "Pumpkin pie", prepTime: "10 min", foodImage: "pumpkin-pie"),
        .init(foodName: "Tomato", prepTime: "10 min", foodImage: "tomato"),
        .init(foodName: "Pumpkin", prepTime: "50 min", foodImage: "pumpkin"),
        .init(foodName: "Rice", prepTime: "20 min", foodImage: "rice"),
        .init(foodName: "Mac-and-cheese", prepTime: "15 min", foodImage: "mac-and-cheese"),
        .init(foodName: "Grilled tacos", prepTime: "30 min", foodImage: "grilled-tacos"),
    ]
    private var currentDataSource: [CellsInfoSections] = []
    
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
    
    func filterResults(with term: String) {
        if term.count > 0 {
            currentDataSource = foodData
            let filteredResults = foodData.filter { $0.foodName.lowercased().contains(term.lowercased()) }
            currentDataSource = filteredResults
            tableView.reloadData()
        }
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
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        filterResults(with: searchText)
        
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
