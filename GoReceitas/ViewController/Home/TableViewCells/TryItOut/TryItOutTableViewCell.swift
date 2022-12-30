//
//  TryItOutTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol TryItOutTableViewCellProtocol {
    func setupCell(cell: DefaultFoodCollectionViewCell)
}

class TryItOutTableViewCell: UITableViewCell {
    private var foodList: [FoodResponse] = [FoodResponse]() {
        didSet {
            pageControl.numberOfPages = foodList.count
        }
    }
    
    private var favoriteKeys: [String] = [String]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: DefaultCellsDelegate?
    
    let database = Database.database().reference()
    
    static let identifier: String = String(describing: TryItOutTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private var hasFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .viewBackgroundColor
        selectionStyle = .none
        configCollectionView()
        checkFavoriteStatusAndUpdate()
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated(_:)), name: .favoritesUpdated, object: nil)
    }
    
    @objc func favoritesUpdated(_ notification: Notification) {
        // Get the additional information from the notification's userInfo property
        if let userInfo = notification.userInfo {
            // Use the information as needed
            let foodID = userInfo.values.first as! String
            if let index = favoriteKeys.firstIndex(of: foodID) {
                favoriteKeys.remove(at: index)
            }
        }
    }
    
    func hasFavorites(food: FoodResponse) -> Bool {
        if favoriteKeys.contains(String(food.id)) {
            print("FAVORITE KEY!!")
            return true
        } else {
            print("NO FAVORITE")
            return false
        }
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = .viewBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DefaultFoodCollectionViewCell.nib(), forCellWithReuseIdentifier: DefaultFoodCollectionViewCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = .init(top: 10, left: 5, bottom: 0, right: 5)
        }
    }
    
    public func configure(with model: [FoodResponse]) {
        self.foodList = model
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func checkFavoriteStatusAndUpdate() {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else { return }
            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
            
            let databaseRef = Database.database().reference()
            
            databaseRef.child("users/\(emailFormatted)").child("favorites").observeSingleEvent(of: .value) { snapshot in
                // provavelmente (pode ser que nao!) o problem esta aqui.. ele so identifica quando há chave
                // tambem precisa detectar a falta dela e retornar algum valor, remover da array ou algo do tipo..
                // talvez quando remova o item tambem remova a key da array ja que ela quem trackeia todas as chaves..
                // como nada esta sendo feito depois de remover os items, as 3 keys (por exemplo) se mantem na array,
                // logo, os coracoes permanecem acesos!
                if let dictionary = snapshot.value as? [String: Any] {
                    for (key, _) in dictionary {
                        self.favoriteKeys.append(key)
                    }
                }
            }
            
//            databaseRef.child("users/\(emailFormatted)").child("favorites").observe(.value) { snapshot in
//                if let dictionary = snapshot.value as? [String: Any] {
//                    for (key, _) in dictionary {
//                        self.favoriteKeys.append(key)
//                    }
//                }
//            }
        }
    }
}

extension TryItOutTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultFoodCollectionViewCell.identifier, for: indexPath) as? DefaultFoodCollectionViewCell {

            let isFavorited = self.hasFavorites(food: self.foodList[indexPath.row])
            cell.setup(model: self.foodList[indexPath.row], isFavorited: isFavorited)
            
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapDefaultFoodCell(food: foodList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if foodList.count > 10 {
            return 10
        }
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 5, height: collectionView.frame.height - 10)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        pageControl.currentPage = visibleIndexPath?.row ?? 1
    }
}

extension TryItOutTableViewCell: DefaultFoodCollectionViewCellDelegate {
    func didTapHeartButton(cell: UICollectionViewCell, isActive: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let foodSelected = foodList[indexPath.row]
        
        delegate?.didFavoriteItem(itemSelected: foodSelected, favorited: isActive)
    }
}

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}
