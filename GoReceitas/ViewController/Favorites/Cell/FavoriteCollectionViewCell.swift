//
//  FavoriteCollectionViewCell.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 21/10/22.
//


import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var heartImage: UIButton!
    
    // mesmo nome do arquivo é nome da classe que é nome do identificador (o mesmo nome pros tres)
    static let identifier: String = "FavoriteCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    weak var viewController: UIViewController?
    weak var delegate: DefaultFoodCollectionViewCellDelegate?
    
    private var isActive: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.layer.cornerRadius = 10.0
        foodImageView.layer.masksToBounds = true
        foodLabel.layer.cornerRadius = 5.0
        foodLabel.layer.masksToBounds = true
        prepTimeLabel.layer.cornerRadius = 10.0
        prepTimeLabel.layer.masksToBounds = true
    }
    
    @IBAction func toggleHeartImage(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }
    
    func setup(model: FoodResponse) {
        foodLabel.text = model.name
        prepTimeLabel.text = model.yields ?? ""
        foodImageView.loadImageUsingCache(withUrl: model.thumbnail_url)
        heartImage.setImage(UIImage(named: "heart-fill"), for: .normal)
        foodLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private func toggleHeartImage(for button: UIButton) {
        showAlert()
    }
    
    func showAlert () {
        let alertController: UIAlertController = UIAlertController(title: "Attention", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didTapHeartButton(cell: self, isActive: false)
        }

        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancel)
        alertController.addAction(ok)

        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}


    



