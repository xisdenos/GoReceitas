import UIKit

class AllTagsViewCell: UICollectionViewCell {
    // cell identifier = "AllTagsViewCell"
    static let identifier = String(describing: AllTagsViewCell.self)
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    func setup(tagInfo: AllTagsModel) {
        self.imageCell.image = UIImage(named: tagInfo.image)
        self.titleLbl.text = tagInfo.title
        self.subtitleLbl.text = tagInfo.subtitle
    }
}
