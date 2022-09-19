import UIKit

class AllTagsViewController: UIViewController {
    private var tags: [AllTagsModel] = [
        .init(image: "lasanha", title: "Especiasi", subtitle: "nada saudável")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AllTagsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagsCell = collectionView.dequeueReusableCell(withReuseIdentifier: AllTagsViewCell.identifier, for: indexPath) as! AllTagsViewCell
        tagsCell.setup(tagInfo: tags[indexPath.row])
        return tagsCell
    }
}
