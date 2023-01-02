import UIKit
import FirebaseDatabase
import FirebaseAuth

class TagsResultsViewController: UIViewController {
    static let identifier = String(describing: TagsResultsViewController.self)
    private var service: Service = Service()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var foodInformation: [FoodResponse] = []
    
    let database = Database.database().reference()
    
    weak var delegate: DefaultCellsDelegate?
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor

        // mantém a cor de fundo da nav bar quando scrollada
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.backgroundColor = .viewBackgroundColor
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        tableView.backgroundColor = .viewBackgroundColor
        tableView.separatorStyle = .none
        
        setActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .viewBackgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    public func configureFoodInformation(foodsInfo: [FoodResponse]) {
//        let foodInfoWithPrepTime = foodsInfo.compactMap({ $0 })
        self.foodInformation = foodsInfo
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TagsResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodInfoCell = tableView.dequeueReusableCell(withIdentifier: TagsResultsTableViewCell.identifier, for: indexPath) as! TagsResultsTableViewCell
        foodInfoCell.delegate = self
        
        if !foodInformation.isEmpty {
            foodInfoCell.setup(foodInfo: foodInformation[indexPath.row])
        }
        return foodInfoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let food = foodInformation[indexPath.row]
        
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            viewController.activityIndicator.startAnimating()
            viewController.foodDetailsView.tableView.isHidden = true
            viewController.foodDetailsView.topFadedLabel.isHidden = true
            viewController.foodDetailsView.purpheHearthView.isHidden = true
            viewController.foodDetailsView.timeView.isHidden = true
            
            self?.service.getMoreInfo(id: food.id) { details in
                switch details {
                case .success(let success):
                    DispatchQueue.main.async {
                        viewController.configureFoodInformation(foodDetails: success)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
            
            self?.service.getSimilarFoods(id: food.id, completion: { result in
                switch result {
                case .success(let success):
                    viewController.configureRecommendedFoods(foods: success.results)
                    
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension TagsResultsViewController: DefaultTableViewCellDelegate {
    func didTapHeartButton(cell: UITableViewCell, isActive: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let foodSelected = foodInformation[indexPath.row]
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
