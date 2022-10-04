import UIKit

class TagsResultsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var foodInformation: [CellsInfoSections] = [
        .init(foodName: "Lasagna", prepTime: "60min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "30min", foodImage: "macarrao"),
        .init(foodName: "Lasagna", prepTime: "60min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "30min", foodImage: "macarrao"),
        .init(foodName: "Lasagna", prepTime: "60min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "30min", foodImage: "macarrao"),
        .init(foodName: "Lasagna", prepTime: "60min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "30min", foodImage: "macarrao"),
        .init(foodName: "Lasagna", prepTime: "60min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "30min", foodImage: "macarrao"),
        .init(foodName: "Lasagna", prepTime: "60min", foodImage: "lasanha"),
        .init(foodName: "Spaghetti", prepTime: "30min", foodImage: "macarrao"),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        resultsLabel.text = "Results (\(foodInformation.count))"
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
