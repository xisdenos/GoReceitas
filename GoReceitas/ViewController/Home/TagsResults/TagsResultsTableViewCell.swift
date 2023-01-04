import UIKit

protocol DefaultTableViewCellDelegate: AnyObject {
    func didTapHeartButton(cell: UITableViewCell, isActive: Bool)
}

class TagsResultsTableViewCell: UITableViewCell {
    // cell identifier = "TagsResultsTableViewCell"
    static let identifier = String(describing: TagsResultsTableViewCell.self)
    private var isActive: Bool = false
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    weak var delegate: DefaultTableViewCellDelegate?
    
    /*
     foodNameContainer.layer.cornerRadius = 5
     favoriteButtonContainer.layer.cornerRadius = 5
     additionalInfoContainer.layer.cornerRadius = 5
     foodImageView.layer.cornerRadius = 5
     
     foodImageView.contentMode = .scaleAspectFill
     foodName.textColor = .white
     additionalInfoLabel.textColor = .white
     */
    
    func setup(foodInfo: FoodResponse, isFavorited: Bool = false) {
        // set image configs
        imageFood.loadImageUsingCache(withUrl: foodInfo.thumbnail_url)
        imageFood.contentMode = .scaleAspectFill
        imageFood.layer.cornerRadius = 10
        imageFood.layer.masksToBounds = true
        
        // set food name and prepTime lbl configs
        foodNameLbl.text = foodInfo.name
        foodNameLbl.textAlignment = .center
        foodNameLbl.font = .systemFont(ofSize: 22, weight: .bold)
        
        prepTimeLbl.textColor = .white
        prepTimeLbl.text = foodInfo.yields ?? "N/A"
        
        isFavorited == true ? heartButton.setImage(UIImage(named: "heart-fill"), for: .normal) : heartButton.setImage(UIImage(named: "heart-empty"), for: .normal)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }
    
    private func toggleHeartImage(for button: UIButton) {
        if isActive == false {
            button.setImage(UIImage(named: "heart-fill"), for: .normal)
            isActive = true
            delegate?.didTapHeartButton(cell: self, isActive: isActive)
        } else if isActive == true {
            button.setImage(UIImage(named: "heart-empty"), for: .normal)
            delegate?.didTapHeartButton(cell: self, isActive: isActive)
            isActive = false
        }
    }
}
