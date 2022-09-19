import UIKit

class AllTagsViewController: UIViewController {
    private var tags: [AllTagsModel] = [
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
        .init(image: "lasanha", title: "Especiais", subtitle: "nada saudável"),
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.size.width / 2) - 20, height: 200)
    }
}
