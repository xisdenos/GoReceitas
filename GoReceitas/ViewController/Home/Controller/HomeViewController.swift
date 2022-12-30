//
//  NewHomeViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    private var tagsList: [TagsResponse] = [TagsResponse]()
    private var tryItOut: [FoodResponse] = [FoodResponse]()
    private var popularList: [FoodResponse] = [FoodResponse]()
    
    private var service: Service = Service()
    
    private var model = NetworkModel()
    
    let database = Database.database().reference()
    
    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        model.delegate = self
        userProfilePictureImageView.image = UIImage(systemName: "person")
        setActivityIndicator()
        setTabBarIcons()
        configObserver()
        configHome()
        fetchData()
//        configTableView()
    }
    
    func fetchData() {
        model.fetchTryItOut { result in
            switch result {
            case .success(let success):
                self.tryItOut = success
            case .failure(let failure):
                print(failure)
            }
        }
//
//        model.fetchTagsList { tags in
//            switch tags {
//            case .success(let tags):
//                self.tagsList = tags
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        model.fetchPopular { result in
            switch result {
            case .success(let success):
                self.popularList = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func configObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage), name: .updateImage, object: nil)
    }
    
    @objc func updateImage(notification: NSNotification){
        userProfilePictureImageView.image = notification.object as? UIImage
    }
    
    func configHome(){
        userProfilePictureImageView.clipsToBounds = true
        userProfilePictureImageView.layer.cornerRadius = 20
        userProfilePictureImageView.layer.masksToBounds = true
        userProfilePictureImageView.contentMode = .scaleAspectFill
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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTagsTableViewCell.identifier) as? CategoryTagsTableViewCell else { return UITableViewCell() }
//            cell.configureTags(with: tagsList)
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TryItOutTableViewCell.identifier) as? TryItOutTableViewCell else { return UITableViewCell() }
            cell.configure(with: tryItOut)
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularFoodsTableViewCell.identifier) as? PopularFoodsTableViewCell else { return UITableViewCell() }
            cell.configure(with: popularList)
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
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.systemPurple
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
    }
    
    // MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewController: CategoryTagsTableViewCellDelegate {
    func categoryChosed(categoryInfo: TagsResponse) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: TagsResultsViewController.identifier) as! TagsResultsViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        viewController.activityIndicator.startAnimating()
        service.getTagSelectedWith(tagName: categoryInfo.name) { tagResult in
            
            switch tagResult {
            case .success(let tags):
                DispatchQueue.main.async {
                    viewController.title = categoryInfo.display_name
                    viewController.configureFoodInformation(foodsInfo: tags.results)
                    viewController.activityIndicator.stopAnimating()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension HomeViewController: DefaultCellsDelegate {
    func didFavoriteItem(itemSelected: FoodResponse, favorited: Bool) {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else { return }
            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
            
            let favArray: [FoodResponse] = [FoodResponse(id: itemSelected.id, name: itemSelected.name, thumbnail_url: itemSelected.thumbnail_url, cook_time_minutes: itemSelected.cook_time_minutes ?? 0, prep_time_minutes: itemSelected.prep_time_minutes ?? 0, yields: itemSelected.yields ?? "n/a")]
            
            let mappedArray = favArray.map { ["name": $0.name, "yields": $0.yields ?? "n/a", "image": $0.thumbnail_url, "isFavorited": favorited, "id": $0.id, "cook_time_minutes": $0.cook_time_minutes ?? 0, "prep_time_minutes": $0.prep_time_minutes ?? 0] }
            
            let dictionary = Dictionary(uniqueKeysWithValues: mappedArray.map { ($0["name"] as! String, $0) })
            
            database.child("users/\(emailFormatted)").child("favorites").child(String(itemSelected.id)).updateChildValues(dictionary)
        } else {
            print("There is no currently signed-in user.")
        }
    }
    
    func didTapDefaultFoodCell(food: FoodResponse) {
        let controller = FoodDetailsViewController()
        navigationController?.pushViewController(controller, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            controller.activityIndicator.startAnimating()
            controller.foodDetailsView.tableView.isHidden = true
            controller.foodDetailsView.topFadedLabel.isHidden = true
            controller.foodDetailsView.purpheHearthView.isHidden = true
            controller.foodDetailsView.timeView.isHidden = true
            self?.service.getMoreInfo(id: food.id) { details in
                switch details {
                case .success(let success):
                    controller.configureFoodInformation(foodDetails: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
            self?.service.getSimilarFoods(id: food.id, completion: { result in
                switch result {
                case .success(let success):
                    controller.configureRecommendedFoods(foods: success.results)
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            })
        }
    }
}

extension HomeViewController: NetworkModelProtocol {
    func success() {
        DispatchQueue.main.async { [weak self] in
            self?.configTableView()
        }
    }
    
    func error(message: String) {
        print(message)
    }
    
    func startLoading() {
        print("start loading")
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        print("stop loading")
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
    }
}
