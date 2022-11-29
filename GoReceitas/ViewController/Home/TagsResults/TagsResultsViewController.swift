import UIKit

class TagsResultsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var foodInformation: [CellsInfoSections] = [
        .init(foodName: "Salad", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Shrimp", prepTime: "30min", foodImage: "salad"),
        .init(foodName: "Potato tacos", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Pizza chicago", prepTime: "30min", foodImage: "salad"),
        .init(foodName: "Grilled tacos", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Lasagna", prepTime: "30min", foodImage: "salad"),
        .init(foodName: "Tomato", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Shrimp", prepTime: "30min", foodImage: "salad"),
        .init(foodName: "Rice", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Pumpkin rice", prepTime: "30min", foodImage: "salad"),
        .init(foodName: "Mac and cheese", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Chicken", prepTime: "30min", foodImage: "salad"),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .viewBackgroundColor
        title = "Tags Results"
        // mantém a cor de fundo da nav bar quando scrollada
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.backgroundColor = .viewBackgroundColor
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        tableView.backgroundColor = .viewBackgroundColor
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension TagsResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodInfoCell = tableView.dequeueReusableCell(withIdentifier: TagsResultsTableViewCell.identifier, for: indexPath) as! TagsResultsTableViewCell
        foodInfoCell.setup(foodInfo: foodInformation[indexPath.row])
        return foodInfoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = FoodDetailsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
