//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit

class SearchViewController: UIViewController {

    public var foodData: [CellsInfoSections] = [
        .init(foodName: "Pumpkin pie", prepTime: "20 min", foodImage: "lasanha")
    ]
    private var currentDataSource: [CellsInfoSections] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSearchBar: UIView!
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Food name..."
        search.searchBar.searchBarStyle = .minimal
//        search.searchResultsUpdater = self
//        search.searchBar.delegate = self
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        self.view.backgroundColor = .viewBackgroundColor
        containerSearchBar.addSubview(searchController.searchBar)
        configTableView()
        currentDataSource = foodData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResultsTableViewCell.nib(), forCellReuseIdentifier: ResultsTableViewCell.identifier)
    }
    
//    func filterResults(with term: String) {
//        if term.count > 0 && !term.isEmpty {
//            currentDataSource = foodData
//            let filteredResults = currentDataSource.filter { $0.replacingOccurrences(of: " ", with: "").lowercased().contains(term.replacingOccurrences(of: " ", with: "").lowercased()) }
//
//            currentDataSource = filteredResults
//            tableView.reloadData()
//        }
//    }
    
//    func populateArrayWith(numberOfItems: Int, nameOfTheProduct: String) {
//        for _ in 1...numberOfItems {
//            foodData.append(nameOfTheProduct)
//        }
//    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
        cell.setup(foodData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text else { return }
//
//        filterResults(with: searchText)
//    }
//}
