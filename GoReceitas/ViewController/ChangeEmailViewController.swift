//
//  changeEmailViewController.swift
//  GoReceitas
//
//  Created by Lorena on 08/09/22.
//

import UIKit

class ChangeEmailViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var newEmailText: UITextField!
    @IBOutlet weak var currentPasswordText: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageRound()
        cornerRadiusElements()
        self.view.backgroundColor = .viewBackgroundColor
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func alertChangeEmail(_ sender: UIButton) {
        alertVerification()
    }
    
    func imageRound() {
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius =  75
    }
    
    func cornerRadiusElements(){
        newEmailText.layer.cornerRadius = 10
        currentPasswordText.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
    }
    
    func alertVerification(){
        if newEmailText.text == "" || currentPasswordText.text == "" {
            let alert = UIAlertController(title: "Erro", message: "Email ou senha inválido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertAction.Style.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Parabéns!", message: "Email alterado com sucesso", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertAction.Style.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
