//
//  NewHomeViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol HomeViewControllerDelegate: AnyObject {
    func startLoading()
    func stopLoading()
}

class HomeViewController: UIViewController {
    private var tagsList: [TagsResponse] = [TagsResponse]()
    private var service: Service = Service()
    
    let firestore = Firestore.firestore()
    var user: [User] = []
    var currentUser = Auth.auth().currentUser
    
    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        delegate = self
        userProfilePictureImageView.image = UIImage(systemName: "person")
        setActivityIndicator()
        configTableView()
        setTabBarIcons()
        configHome()
        print("home", #function)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        getUserData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func getUserData(){
        firestore.collection("usuarios").getDocuments { snapchot, error in
            if error == nil {
                if let snapchot {
                    DispatchQueue.main.async {
                        self.user = snapchot.documents.map({ document in
                            print("bola \(self.currentUser?.email)")
                            return User(nome: document["nome"] as? String ?? "",
                                        email: document["email"] as? String ?? "",
                        image: document["image"] as? String ?? "")
                        })
                        self.populateView(index: self.getIndex(email: self.currentUser?.email ?? ""))
                        print(self.currentUser?.email)
                        print(self.user)
                    }
                }
            }
        }
    }
    
    
    func populateView(index: Int){
        welcomeLabel.text = "Hello, \(user[index].nome.capitalized)!"
        let url = URL(string: user[index].image) ?? URL(fileURLWithPath: "")
        userProfilePictureImageView.af.setImage(withURL: url)
    }
    
    func getIndex(email: String) -> Int {
        let index = user.firstIndex { $0.email == email } ?? 0
        print("banana \(index)")
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
//            service.getTagsList { tags in
//                switch tags {
//                case .success(let tags):
//                    cell.configureTags(with: tags.results)
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TryItOutTableViewCell.identifier) as? TryItOutTableViewCell else { return UITableViewCell() }
//            delegate?.startLoading()
//            service.getFoodList { [weak self] result in
//                switch result {
//                case .success(let success):
//                    let filteredArray = success.results.filter({ $0.yields != nil })
//
//                    cell.configure(with: filteredArray.shuffled())
//                    self?.delegate?.stopLoading()
//                case .failure(let failure):
//                    self?.delegate?.stopLoading()
//                    print(failure.localizedDescription)
//                }
//            }
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularFoodsTableViewCell.identifier) as? PopularFoodsTableViewCell else { return UITableViewCell() }
            cell.activityIndicator.startAnimating()
//            service.getPopularList { result in
//                switch result {
//                case .success(let success):
//                    let popularRecipes = success.results?.compactMap({ $0.item }).filter({ $0.recipes != nil })
//
//                    if let popularRecipes {
//                        cell.configure(with: popularRecipes)
//                        cell.activityIndicator.stopAnimating()
//                    }
//
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
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

extension HomeViewController: HomeViewControllerDelegate {
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

extension HomeViewController: DefaultCellsDelegate {
    func didTapFoodCell(food: FoodResponse) {
        
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

extension HomeViewController: PopularFoodsTableViewCellDelegate {
    func didTapFoodCell(food: PopularResponseDetails) {
        guard let food = food.recipes?[0] else { return }
        
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
