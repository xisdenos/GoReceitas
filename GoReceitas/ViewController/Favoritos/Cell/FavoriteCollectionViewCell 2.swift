//
//  FavoriteCollectionViewCell.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 21/10/22.
//

protocol FavoriteCollectionViewCellDelegate: AnyObject {
    func didTapHeartButton(cell: UICollectionViewCell)
}

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
    weak var delegate: FavoriteCollectionViewCellDelegate?
    weak var viewController: UIViewController?
    
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
    
    
    func setupCell(foodinfo: CellsInfoSections){
        foodImageView.image = UIImage(named: foodinfo.foodImage)
        prepTimeLabel.text = foodinfo.prepTime
        foodLabel.text = foodinfo.foodName
    }
    
    
    @IBAction func toggleHeartImage(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }

    
    private func toggleHeartImage(for button: UIButton) {
        showAlert()
    }
    
    func showAlert () {
        let alertController: UIAlertController = UIAlertController(title: "Atenção", message: "Tem certeza que deseja remover esse item?", preferredStyle: .alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "ok", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.isActive = false
            self.delegate?.didTapHeartButton(cell: self)
        }

        let cancel: UIAlertAction = UIAlertAction(title: "cancelar", style: .destructive)
        alertController.addAction(cancel)
        alertController.addAction(ok)

        viewController?.present(alertController, animated: true, completion: nil)
    }
    
}


    



