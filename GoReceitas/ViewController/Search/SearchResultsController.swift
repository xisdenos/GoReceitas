//
//  SearchResultsController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 02/01/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

enum TableViewState {
    case normal
    case noResults
}

class SearchResultsController: UIViewController {
    
    var state: TableViewState = .normal
    
    public var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    weak var delegate: DefaultCellsDelegate?
    
    public var foodResult: [FoodResponse] = []
    
    public var isSearchFailed: Bool = false
    public var configTableViewBool: Bool = false
    
    private var favoriteKeys: [String] = [String]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    let database = Database.database().reference()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .viewBackgroundColor
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackgroundColor
        view.addSubview(tableView)
        setActivityIndicator()
        configTableView()
        checkFavoriteStatusAndUpdate()
    }
    
    func setActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func hasFavorites(food: FoodResponse) -> Bool {
        if favoriteKeys.contains(String(food.id)) {
            return true
        } else {
            return false
        }
    }
    
    func checkFavoriteStatusAndUpdate() {
        let userEmail = Favorite.getCurrentUserEmail
        
        database.child("users/\(userEmail)").child("favorites").observe(.value) { snapshot in
            if let dictionary = snapshot.value as? [String: Any] {
                self.favoriteKeys.removeAll()
                for (key, _) in dictionary {
                    self.favoriteKeys.append(key)
                }
            }
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .viewBackgroundColor
        tableView.register(ResultsTableViewCell.nib(), forCellReuseIdentifier: ResultsTableViewCell.identifier)
        tableView.register(EmptySearchTableViewCell.nib(), forCellReuseIdentifier: EmptySearchTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SearchResultsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .normal:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
            if !foodResult.isEmpty {
                let isFavorited = hasFavorites(food: foodResult[indexPath.row])

                cell.setup(foodResult[indexPath.row], isFavorited: isFavorited)
                cell.delegate = self
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                }
            }
            return cell
        case .noResults:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptySearchTableViewCell.identifier, for: indexPath) as! EmptySearchTableViewCell
            cell.setup(message: "No results found")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapDefaultFoodCell(food: foodResult[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .normal:
            return foodResult.count
        case .noResults:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !foodResult.isEmpty ? 175 : tableView.frame.size.height - 100
//        return 175
    }
}

extension SearchResultsController: DefaultTableViewCellDelegate {
    func didTapHeartButton(cell: UITableViewCell, isActive: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let foodSelected = foodResult[indexPath.row]
        let foodId = String(foodSelected.id)
        let userEmail = Favorite.getCurrentUserEmail
        
        database.child("users/\(userEmail)").child("favorites").observeSingleEvent(of: .value) { snapshot in
            if snapshot.hasChild(foodId) {
                Favorite.unfavoriteItem(at: foodSelected, database: self.database)
            } else {
                self.delegate?.didFavoriteItem(itemSelected: foodSelected, favorited: isActive)
            }
        }
    }
}

