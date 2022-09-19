import UIKit

class CategoryViewCell: UICollectionViewCell {
    // cell identifier = "CategoryViewCell"
    static let identifier = String(describing: CategoryViewCell.self)
    private let gradient = CAGradientLayer()
    
    @IBOutlet weak var categoryButton: UIButton!
    
    func setup(_ tagInfo: CellsInfoSections) {
        self.categoryButton.setTitle(tagInfo.categoryName, for: .normal)
        self.categoryButton.layer.borderWidth = 1
        self.categoryButton.layer.borderColor = UIColor.systemPurple.cgColor
//        self.categoryButton.setTitleColor(UIColor.systemPurple, for: .normal)
//        let purple = UIColor(red: 149/255, green: 2/255, blue: 239/255, alpha: 1)
//        let purple2 = UIColor(red: 73/255, green: 0/255, blue: 119/255, alpha: 1)
//        gradient.colors = [purple, purple2]
//        gradient.frame = categoryButton.bounds
//        gradient.startPoint = .zero
//        categoryButton.layer.insertSublayer(gradient, at: 0)
    }
}
