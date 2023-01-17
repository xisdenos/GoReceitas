//
//  NewHomeViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    private let firestore = Firestore.firestore()
    private var user: [User] = []
    private var viewModel: HomeViewModel = HomeViewModel()
    private var currentUser = Auth.auth().currentUser
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.set(delegate: self)
        
        view.backgroundColor = .viewBackgroundColor
        tableView.backgroundColor = .viewBackgroundColor
        userProfilePictureImageView.image = UIImage(named: "profileImage")
        setActivityIndicator()
        setTabBarIcons()
        configHome()
        
        activityIndicator.startAnimating()
        
        Task {
            await viewModel.fetchData() { [weak self] in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.configTableView()
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        getUserData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func getUserData() {
        firestore.collection("usuarios").getDocuments { snapchot, error in
            if error == nil {
                if let snapchot {
                    DispatchQueue.main.async {
                        self.user = snapchot.documents.map({ document in
                            return User(nome: document["nome"] as? String ?? "",
                                        email: document["email"] as? String ?? "",
                                        image: document["image"] as? String ?? "")
                        })
                        self.populateView(index: self.getIndex(email: self.currentUser?.email ?? ""))
                    }
                }
            }
        }
    }
    
    @objc func updateImage(notification: NSNotification){
        userProfilePictureImageView.image = notification.object as? UIImage
    }
    
    func populateView(index: Int){
        welcomeLabel.text = "Hello, \(user[index].nome.capitalized)!"
        let url = URL(string: user[index].image) ?? URL(fileURLWithPath: "")
        userProfilePictureImageView.af.setImage(withURL: url)
    }
    
    func getIndex(email: String) -> Int {
        let index = user.firstIndex { $0.email == email } ?? 0
        return index
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
            cell.configureTags(with: viewModel.tagsList)
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TryItOutTableViewCell.identifier) as? TryItOutTableViewCell else { return UITableViewCell() }
            cell.configure(with: viewModel.tryItOut)
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularFoodsTableViewCell.identifier) as? PopularFoodsTableViewCell else { return UITableViewCell() }
            if !viewModel.isPopularListEmpty {
                cell.configure(with: viewModel.popularList)
            }
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
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        viewController.activityIndicator.startAnimating()
        
        viewModel.fetchTags(categoryInfo, tagsController: viewController)
    }
}

extension HomeViewController: DefaultCellsDelegate {
    func didFavoriteItem(itemSelected: FoodResponse, favorited: Bool) {
        Favorite.favoriteItem(itemSelected: itemSelected, favorited: favorited, database: viewModel.database)
    }
    
    func didTapDefaultFoodCell(food: FoodResponse) {
        let controller = FoodDetailsViewController()
        controller.foodId = food.id
        navigationController?.pushViewController(controller, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            controller.activityIndicator.startAnimating()
            controller.foodDetailsView.tableView.isHidden = true
            controller.foodDetailsView.topFadedLabel.isHidden = true
            controller.foodDetailsView.purpheHearthView.isHidden = true
            controller.foodDetailsView.timeView.isHidden = true
            
            self?.viewModel.fetchMoreInfo(food) { result in
                switch result {
                case .success(let success):
                    controller.configureFoodInformation(foodDetails: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
            self?.viewModel.fetchSimilarFoods(food, completion: { result in
                switch result {
                case .success(let success):
                    controller.configureRecommendedFoods(foods: success)
                case .failure(let failure):
                    print(failure)
                }
            })
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func success() {
        
    }
    
    func error(message: String) {
        
    }
    
    func startLoading() {
        
    }
    
    func stopLoading() {
    
    }
    
    func successTags(_ tagResponse: [FoodResponse], tagsController: TagsResultsViewController) {
        
    }
    
}
