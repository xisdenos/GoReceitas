import UIKit


class HeaderViewCell: UICollectionReusableView {
    // cell identifier = "HeaderViewCell"
    static let identifier = String(describing: HeaderViewCell.self)
    
    @IBOutlet weak var seeAllTags: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    
    func setup(_ title: String, isHidden: Bool = true) {
        self.headerTitle.text = title
        self.seeAllTags.setTitle("VER TUDO", for: .normal)
        self.seeAllTags.isHidden = isHidden
        self.seeAllTags.titleLabel?.textAlignment = .center
    }
}
