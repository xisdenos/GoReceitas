//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit

class SearchViewController: UIViewController {

    public var foodData: [String] = []
    private var currentDataSource: [String] = []
    
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
        self.view.backgroundColor = .viewBackgroundColor
        containerSearchBar.addSubview(searchController.searchBar)
        configTableView()
        
        populateArrayWith(numberOfItems: 5, nameOfTheProduct: "Macbook")
        populateArrayWith(numberOfItems: 5, nameOfTheProduct: "iPhone")
        populateArrayWith(numberOfItems: 5, nameOfTheProduct: "iMac")
        
        currentDataSource = foodData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func filterResults(with term: String) {
        if term.count > 0 && !term.isEmpty {
            currentDataSource = foodData
            let filteredResults = currentDataSource.filter { $0.replacingOccurrences(of: " ", with: "").lowercased().contains(term.replacingOccurrences(of: " ", with: "").lowercased()) }
            
            currentDataSource = filteredResults
            tableView.reloadData()
        }
    }
    
    func populateArrayWith(numberOfItems: Int, nameOfTheProduct: String) {
        for _ in 1...numberOfItems {
            foodData.append(nameOfTheProduct)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath)
        cell.textLabel?.text = currentDataSource[indexPath.row]
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        filterResults(with: searchText)
    }
}
