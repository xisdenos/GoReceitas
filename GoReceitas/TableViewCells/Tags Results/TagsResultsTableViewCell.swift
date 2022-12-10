import UIKit

class TagsResultsTableViewCell: UITableViewCell {
    // cell identifier = "TagsResultsTableViewCell"
    static let identifier = String(describing: TagsResultsTableViewCell.self)
    private var isActive: Bool = false
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    func setup(foodInfo: FoodResponse) {
        // set image configs
        imageFood.loadImageUsingCache(withUrl: foodInfo.thumbnail_url)
        imageFood.contentMode = .scaleAspectFill
        imageFood.layer.cornerRadius = 10
        imageFood.layer.masksToBounds = true
        
        // set food name and prepTime lbl configs
        foodNameLbl.text = foodInfo.name
        if let cookTime = foodInfo.cook_time_minutes ?? foodInfo.prep_time_minutes {
            prepTimeLbl.text = "\(cookTime) minutes"   
        }
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }
    
    private func toggleHeartImage(for button: UIButton) {
        if isActive == false {
            button.setImage(UIImage(named: "heart-fill"), for: .normal)
            isActive = true
        } else if isActive == true {
            button.setImage(UIImage(named: "heart-empty"), for: .normal)
            isActive = false
        }
    }
}
