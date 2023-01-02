//
//  SearchResultsController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 02/01/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SearchResultsController: UIViewController {
    
    public var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    weak var delegate: DefaultCellsDelegate?
    
    public var foodResult: [FoodResponse] = []
    
    let database = Database.database().reference()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackgroundColor
        view.addSubview(tableView)
        setActivityIndicator()
        configTableView()
    }
    
    func setActivityIndicator() {
        tableView.addSubview(activityIndicator)
//        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .viewBackgroundColor
        tableView.register(ResultsTableViewCell.nib(), forCellReuseIdentifier: ResultsTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SearchResultsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
        if !foodResult.isEmpty {
            cell.setup(foodResult[indexPath.row])
            cell.delegate = self
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapDefaultFoodCell(food: foodResult[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodResult.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
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

