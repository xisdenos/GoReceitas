//
//  FavoriteEmptyVC.swift
//  GoReceitas
//
//  Created by Daiane Goncalves on 21/10/22.
//

import UIKit

class FavoriteEmptyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func TappedAlertButton(_ sender: UIButton) {
        let alertController: UIAlertController = UIAlertController(title: "Atenção", message: "Tem certeza que deseja remover esse item?", preferredStyle: .alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "ok", style: .default) {
            (action) in
            print("Você clicou no botão ok")}
        
        let cancel: UIAlertAction = UIAlertAction(title: "cancelar", style: .destructive) {
            (action) in
            print("Você clicou no botão cancelar")
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
