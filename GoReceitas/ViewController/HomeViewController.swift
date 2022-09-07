import UIKit

class HomeViewController: UIViewController {
    private let sections = MockData.shared.data
    
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
            let section = self.sections[sectionIndex]
            
            switch section {
            case .categories:
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
            case .tryItOut:
                // item
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.45)), subitems: [item])
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 7
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 5, bottom: 5, trailing: 5)
                section.supplementariesFollowContentInsets = false
                
                return section
            case .popular:
                // item
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.45)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                // group
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.7)), subitems: [item])
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .groupPaging
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 10, trailing: 10)
                section.supplementariesFollowContentInsets = false
                
                return section
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .categories(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as! CategoryViewCell
            cell.setup(item[indexPath.row])
            return cell
        case .tryItOut(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TryItOutCell.identifier, for: indexPath) as! TryItOutCell
            cell.setup(item[indexPath.row])
            return cell
        case .popular(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularViewCell.identifier, for: indexPath) as! PopularViewCell
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
