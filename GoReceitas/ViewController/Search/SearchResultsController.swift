//
//  SearchResultsController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 02/01/23.
//

import UIKit


protocol SearchResultsControllerProtocol: AnyObject {
    func startLoading()
    func stopLoading()
}

class SearchResultsController: UIViewController, DefaultTableViewCellDelegate {
    func didTapHeartButton(cell: UITableViewCell, isActive: Bool) {
        
    }
    
    public var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    weak var loadingDelegate: SearchResultsControllerProtocol?
    
    weak var delegate: DefaultCellsDelegate?
    
    public var foodResult: [FoodResponse] = []
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .viewBackgroundColor
        view.addSubview(tableView)
        
//        loadingDelegate?.startLoading()
        
        setActivityIndicator()
        configTableView()
        setTableViewConstraints()
    }
    
    func setActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .viewBackgroundColor
        tableView.register(ResultsTableViewCell.nib(), forCellReuseIdentifier: ResultsTableViewCell.identifier)
    }
    
    func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
}

extension SearchResultsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
        if !foodResult.isEmpty {
            cell.setup(foodResult[indexPath.row])
            cell.delegate = self
        }
        print("array count", foodResult.count, #function)
//        cell.setup(foodResult[indexPath.row])
//        cell.delegate = self
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
