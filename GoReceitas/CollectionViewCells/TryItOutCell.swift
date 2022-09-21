import UIKit

class TryItOutCell: UICollectionViewCell {
    // cell identifier = "TryItOutCell"
    static let identifier = String(describing: TryItOutCell.self)
    var isActive: Bool = false
    
    @IBOutlet weak var foogImg: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var prepTimeLbl: UILabel!
    
    func setup(_ foodInfo: CellsInfoSections) {
        self.foogImg.image = UIImage(named: foodInfo.foodImage ?? "")
        self.foodNameLbl.text = foodInfo.foodName
        self.prepTimeLbl.text = foodInfo.prepTime
    }
    
    @IBAction func heartButton(_ sender: UIButton) {
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
