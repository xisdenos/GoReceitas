//
//  NewHomeViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        userProfilePictureImageView.image = UIImage(systemName: "person")
        configTableView()
        setTabBarIcons()
        configObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func configObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage), name: .updateImage, object: nil)
    }
    
    @objc func updateImage(){
        userProfilePictureImageView.image = UIImage(named: "heart-fill")
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .viewBackgroundColor
        tableView.separatorStyle = .none
        tableView.register(CategoryTagsTableViewCell.nib(), forCellReuseIdentifier: CategoryTagsTableViewCell.identifier)
        tableView.register(TryItOutTableViewCell.nib(), forCellReuseIdentifier: TryItOutTableViewCell.identifier)
        tableView.register(PopularFoodsTableViewCell.nib(), forCellReuseIdentifier: PopularFoodsTableViewCell.identifier)
    }
    
    private func setTabBarIcons() {
        self.tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house")
        self.tabBarController?.tabBar.items?[1].image = UIImage(systemName: "magnifyingglass")
        self.tabBarController?.tabBar.items?[2].image = UIImage(systemName: "heart")
        self.tabBarController?.tabBar.items?[3].image = UIImage(systemName: "person")
        
        self.tabBarController?.tabBar.items?[0].title = "Home"
        self.tabBarController?.tabBar.items?[1].title = "Search"
        self.tabBarController?.tabBar.items?[2].title = "Favorites"
        self.tabBarController?.tabBar.items?[3].title = "Profile"
    }
    
    @objc func allTagsTapped() {
        print(#function)
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AllTagsViewController") as! AllTagsViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTagsTableViewCell.identifier) as? CategoryTagsTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TryItOutTableViewCell.identifier) as? TryItOutTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularFoodsTableViewCell.identifier) as? PopularFoodsTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Categories"
        case 1:
            return "Try it out"
        case 2:
            return "Popular"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        } else if indexPath.section == 1 {
            return 250
        } else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            guard let header = view as? UITableViewHeaderFooterView else { return }
            let allTagsButton: UIButton = UIButton(frame: CGRect(x: header.frame.midX + 120, y: 0, width: 50, height: 30))
            allTagsButton.setTitle("All Tags", for: .normal)
            allTagsButton.setTitleColor(.systemPurple, for: .normal)
            allTagsButton.addTarget(self, action: #selector(allTagsTapped), for: .touchUpInside)
            allTagsButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            allTagsButton.titleLabel?.textAlignment = .center
            allTagsButton.titleLabel?.numberOfLines = 0
            
            header.addSubview(allTagsButton)
            
            header.textLabel?.textColor = UIColor.systemPurple
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            header.textLabel?.frame = header.bounds
        }
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.systemPurple
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
    }
    
    // MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: CategoryTagsTableViewCellDelegate {
    func categoryChosed() {
        print("category chosed")
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TagsResultsViewController") as! TagsResultsViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: DefaultCellsDelegate {
    func didTapFoodCell() {
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
