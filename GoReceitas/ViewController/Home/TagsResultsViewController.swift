import UIKit

class TagsResultsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var foodInformation: [CellsInfoSections] = [
        .init(foodName: "Salad", prepTime: "60min", foodImage: "salad"),
        .init(foodName: "Shrimp", prepTime: "30min", foodImage: "shrimp"),
        .init(foodName: "Potato tacos", prepTime: "60min", foodImage: "potato-tacos"),
        .init(foodName: "Pizza chicago", prepTime: "30min", foodImage: "pizza-chicago"),
        .init(foodName: "Grilled tacos", prepTime: "60min", foodImage: "grilled-tacos"),
        .init(foodName: "Lasagna", prepTime: "30min", foodImage: "lasanha"),
        .init(foodName: "Tomato", prepTime: "60min", foodImage: "tomato"),
        .init(foodName: "Shrimp", prepTime: "30min", foodImage: "shrimp"),
        .init(foodName: "Rice", prepTime: "60min", foodImage: "rice"),
        .init(foodName: "Pumpkin rice", prepTime: "30min", foodImage: "pumpkin-pie"),
        .init(foodName: "Mac and cheese", prepTime: "60min", foodImage: "mac-and-cheese"),
        .init(foodName: "Chicken", prepTime: "30min", foodImage: "chicken"),
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
