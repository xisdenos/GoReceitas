//
//  FoodDetailsViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

enum DetailsSections: Int {
    case details = 0
    case description = 1
    case recommended = 2
}

class FoodDetailsViewController: UIViewController {
    
    lazy var foodDetailsView: FoodDetailsView = {
        let foodview = FoodDetailsView()

        foodview.tableView.delegate = self
        foodview.tableView.dataSource = self
        return foodview
    }()
    
    override func loadView() {
        super.loadView()
        view = foodDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension FoodDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedFoodsTableViewCell.identifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case DetailsSections.details.rawValue:
            return 100
        default:
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case DetailsSections.details.rawValue:
            return "Details"
        case DetailsSections.description.rawValue:
            return "Instructions"
        case DetailsSections.recommended.rawValue:
            return "You may also like"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch section {
        case DetailsSections.details.rawValue:
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = UIColor.black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            header.textLabel?.frame = header.bounds
            header.textLabel?.textAlignment = .center
        default:
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.textColor = UIColor.black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            header.textLabel?.frame = header.bounds
            header.textLabel?.textAlignment = .left
        }
    }
}
