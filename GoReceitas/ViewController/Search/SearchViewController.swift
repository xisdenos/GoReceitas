//
//  SearchViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 03/10/22.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func startLoading()
    func stopLoading()
}

class SearchViewController: UIViewController {
    private var service: Service = Service()

    public var foodData: [FoodResponse] = []
    
    private var currentDataSource: [FoodResponse] = []
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    weak var delegate: SearchViewControllerProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSearchBar: UIView!
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
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
        delegate = self
        
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
        }
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
            self.delegate?.startLoading()
            service.searchFoodWith(term: searchText) { [weak self] foodsResult in
                switch foodsResult {
                case .success(let foods):
                    self?.currentDataSource = foods.results
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.delegate?.stopLoading()
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

extension SearchViewController: SearchViewControllerProtocol {
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.isHidden = false
        }
    }
}
