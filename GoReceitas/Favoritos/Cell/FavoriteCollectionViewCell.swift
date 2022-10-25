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
    
    @IBOutlet weak var heartButton: UIButton!
    
    // mesmo nome do arquivo é nome da classe que é nome do identificador (o mesmo nome pros tres)
    static let identifier: String = "FavoriteCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
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
        foodImageView.image = UIImage(named: foodinfo.foodImage ?? "")
        prepTimeLabel.text = foodinfo.prepTime
        foodLabel.text = foodinfo.foodName
        
    }
    
    @IBAction func toggleHeartImage(_ sender: UIButton) {
        toggleHeartImage(for: sender)
    }
    
    //func original
//    private func toggleHeartImage(for button: UIButton) {
//        if isActive == false {
//            button.setImage(UIImage(named: "heart-fill-fav"), for: .normal)
//            isActive = true
//        } else if isActive == true {
//            button.setImage(UIImage(named: "heart-empty-fav"), for: .normal)
//            isActive = false
//        }
//    }
    
    private func toggleHeartImage(for button: UIButton) {
        if isActive == false {
            button.setImage(UIImage(named: "heart-fill-fav"), for: .normal)
            isActive = true
        } else if isActive == true {
            button.setImage(UIImage(named: "heart-empty-fav"), for: .normal)
            isActive = false
        }
    }

    //modelo
//    @IBAction func TappedAlertButton(_ sender: UIButton) {
//        let alertController: UIAlertController = UIAlertController(title: "Atenção", message: "Tem certeza que deseja remover esse item?", preferredStyle: .alert)
//
//        let ok: UIAlertAction = UIAlertAction(title: "ok", style: .default) {
//            (action) in
//            print("Você clicou no botão ok")}
//
//        let cancel: UIAlertAction = UIAlertAction(title: "cancelar", style: .destructive) {
//            (action) in
//            print("Você clicou no botão cancelar")
//        }
//        alertController.addAction(cancel)
//        alertController.addAction(ok)
//
//        self.present(alertController, animated: true, completion: nil)
//
//    }
    
}


