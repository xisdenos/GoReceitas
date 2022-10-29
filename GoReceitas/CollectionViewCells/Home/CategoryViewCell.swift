import UIKit

class CategoryViewCell: UICollectionViewCell {
    // cell identifier = "CategoryViewCell"
    static let identifier = String(describing: CategoryViewCell.self)
    
    @IBOutlet weak var categoryButton: UIButton!
    
    func setup(_ tagInfo: CellsInfoSections) {
        self.categoryButton.setTitle(tagInfo.categoryName, for: .normal)
        self.categoryButton.layer.borderWidth = 1
        self.categoryButton.layer.borderColor = UIColor.systemPurple.cgColor
    }
}
