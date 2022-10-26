//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit

class SearchViewController: UIViewController {

    public var foodData: [CellsInfoSections] = [
        .init(foodName: "Pumpkin pie", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Lasagna", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "X-Burguer", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Cake", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Tomato", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Scrambled eggs", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Parmegiana", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "20 min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "20 min", foodImage: "lasanha"),
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
            let filteredResults = foodData.filter { $0.foodName?.lowercased().contains(term.lowercased()) ?? false }
            currentDataSource = filteredResults
            tableView.reloadData()
        }
        
//        if term.count > 0 {
//            currentDataSource = originalDataSource
//            let filtered = originalDataSource.filter { $0.name.lowercased().contains(term.lowercased()) ||
//                $0.occupation.lowercased().contains(term.lowercased()) ||
//                String($0.age).lowercased().contains(term.lowercased())
//            }
//
//            currentDataSource = filtered
//            tableView.reloadData()
//        }
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
