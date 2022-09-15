import UIKit

class HomeViewController: UIViewController {
    private let sections = MockData.shared.data
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(FooterViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterViewCell.identifier)
    }
    
    // MARK: Create and set constraints for page control
    lazy var pageControlProg: UIPageControl = {
        let pc = UIPageControl()
        
        pc.numberOfPages = sections[1].count
        pc.currentPage = 0
        pc.pageIndicatorTintColor = .white
        pc.currentPageIndicatorTintColor = .purple
        pc.isUserInteractionEnabled = false
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        return pc
    }()
    
    func setupPageControl(_ footer: UICollectionReusableView) {
        footer.addSubview(pageControlProg)
        
        NSLayoutConstraint.activate([
            pageControlProg.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            pageControlProg.centerYAnchor.constraint(equalTo: footer.centerYAnchor),
        ])
    }
    
    
    // MARK: Create compositional layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layountEnvironment in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            
            switch section {
            case .categories:
                // item
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)))
                
                // group
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.35)), subitems: [item])
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 5, trailing: 0)
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [self.addSupplementaryView()]
                
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 20, trailing: 5)
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [self.addSupplementaryView(), self.addSupplementaryFooter()]
                section.visibleItemsInvalidationHandler = { items, contentOffset, environment in
                    let currentPageTryItOut = Int(round(contentOffset.x / self.collectionView.bounds.size.width))
                    self.pageControlProg.currentPage = currentPageTryItOut
                }
                
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 10)
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [self.addSupplementaryView()]
                
                return section
            }
        }
    }
    
    // MARK: Create HEADER and FOOTER
    private func addSupplementaryView() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func addSupplementaryFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
    }
}

    // MARK: Set delegates for collection view
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch sections[indexPath.section] {
            case .categories:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.identifier, for: indexPath) as! HeaderViewCell
                header.setup(sections[indexPath.section].title, isHidden: false)
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.identifier, for: indexPath) as! HeaderViewCell
                header.setup(sections[indexPath.section].title)
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterViewCell.identifier, for: indexPath)
            setupPageControl(footer)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: Extension for storyboard
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
