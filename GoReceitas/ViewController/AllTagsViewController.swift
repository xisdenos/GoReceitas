import UIKit

class AllTagsViewController: UIViewController {
    private var tags: [AllTagsModel] = [
        .init(image: "japanese", title: "Japanese", subtitle: "Cuisine"),
        .init(image: "healthy", title: "Healthy", subtitle: "Dietary"),
        .init(image: "snacks", title: "Snacks", subtitle: "Meal"),
        .init(image: "indian", title: "Indian", subtitle: "Cuisine"), 
        .init(image: "taiwanese", title: "Taiwanese", subtitle: "Cuisine"),
        .init(image: "italian", title: "Italian", subtitle: "Cuisine"),
        .init(image: "middle-eastern", title: "Middle Eastern", subtitle: "Cuisine"),
        .init(image: "breakfast", title: "Breakfast", subtitle: "Meal"),
        .init(image: "bbq", title: "Barbecue", subtitle: "BBQ"),
        .init(image: "vegetarian", title: "Vegetarian", subtitle: "Dietary"),
         
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
        tagsCell.layer.borderWidth = 2
        tagsCell.layer.borderColor = CGColor(red: 73 / 255, green: 0 / 255, blue: 119 / 255, alpha: 1)
        tagsCell.cornerRadius = 10
        return tagsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.size.width / 2) - 20, height: 200)
    }
}
