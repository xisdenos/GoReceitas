import UIKit

class TagsResultsViewController: UIViewController {
    static let identifier = String(describing: TagsResultsViewController.self)
    private var service: Service = Service()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var foodInformation: [FoodResponse] = []
    
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
        
//        let food = foodInformation[indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
