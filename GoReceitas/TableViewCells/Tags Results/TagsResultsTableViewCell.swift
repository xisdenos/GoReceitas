import UIKit

class TagsResultsTableViewCell: UITableViewCell {
    // cell identifier = "TagsResultsTableViewCell"
    static let identifier = String(describing: TagsResultsTableViewCell.self)
    private var isActive: Bool = false
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    func setup(foodInfo: CellsInfoSections) {
        // set image configs
        self.imageFood.image = UIImage(named: foodInfo.foodImage)
        self.imageFood.contentMode = .scaleAspectFill
        self.imageFood.layer.cornerRadius = 10
        self.imageFood.layer.masksToBounds = true
        // set food name and prepTime lbl configs
        self.foodNameLbl.text = foodInfo.foodName
        self.prepTimeLbl.text = foodInfo.prepTime
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
