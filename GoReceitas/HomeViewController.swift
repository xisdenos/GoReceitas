import UIKit

class HomeViewController: UIViewController {
    private let categories = MockData.shared.data
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var homeBarButtonItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = "Olá, usuário"
        self.homeBarButtonItem.title = "Home"
        self.homeBarButtonItem.image = UIImage(named: "home")
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layountEnvironment in
            guard let self = self else { return nil }
            let section = self.categories[sectionIndex]
            
            switch section {
            case .category:
                // item
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)))
                
                // group
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.33)), subitems: [item])
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 7
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 5, trailing: 20)
                section.supplementariesFollowContentInsets = false
                
                return section
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch categories[indexPath.section] {
        case .category(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as! CategoryViewCell
            cell.setup(item[indexPath.row])
            return cell
        }
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
