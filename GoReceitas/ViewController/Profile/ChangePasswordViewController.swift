//
//  changePasswordViewController.swift
//  GoReceitas
//
//  Created by Lorena on 08/09/22.
//

import UIKit

class ChangePasswordViewController: UIViewController {

  
//    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var currentPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var confirmNewPasswordText: UITextField!
    @IBOutlet weak var saveEditionsButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        imageRound()
        configFontAndColors()
        self.view.backgroundColor = .viewBackgroundColor
//       configObeserver()
        print("senha", #function)
    }

    @IBAction func tapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func alertNewPassword(_ sender: UIButton) {
        alertVerification()
    }
    
    
//    func imageRound() {
//        imageProfile.layer.masksToBounds = true
//        imageProfile.layer.cornerRadius =  75
//    }
    
//    func configObeserver(){
//        NotificationCenter.default.addObserver(self, selector: #selector(updateImageSenha), name: .updateImage, object: nil)
//    }
//
//    @objc func updateImageSenha(notification: NSNotification){
//        imageProfile.image = notification.object as? UIImage
//    }
    
    func configFontAndColors(){
        saveEditionsButton.isEnabled = false
        
        currentPasswordText.layer.cornerRadius = 10
        newPasswordText.layer.cornerRadius = 10
        confirmNewPasswordText.layer.cornerRadius = 10
        saveEditionsButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
        currentPasswordText.delegate = self
        newPasswordText.delegate = self
        confirmNewPasswordText.delegate = self

    }
    
    func alertVerification(){
        if currentPasswordText.text == "" || newPasswordText.text == "" || confirmNewPasswordText.text == ""{
            let alert = UIAlertController(title: "Senha incorreta", message: "As senhas digitadas não são compatíveis", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertAction.Style.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Parabéns!", message: "Senha alterada com sucesso!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",style: UIAlertAction.Style.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ChangePasswordViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if currentPasswordText.text == "" || newPasswordText.text == "" || confirmNewPasswordText.text == "" {
            saveEditionsButton.isEnabled = false
        } else {
            
            if newPasswordText.text == confirmNewPasswordText.text {
                saveEditionsButton.isEnabled = true
            }else{
                newPasswordText.layer.borderColor = UIColor.red.cgColor
                confirmNewPasswordText.layer.borderColor = UIColor.red.cgColor
                saveEditionsButton.isEnabled = false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(self.currentPasswordText){
            self.currentPasswordText.resignFirstResponder()
            self.newPasswordText.becomeFirstResponder()
        }else if textField.isEqual(self.newPasswordText){
            self.newPasswordText.resignFirstResponder()
            self.confirmNewPasswordText.becomeFirstResponder()
        }else{
            self.confirmNewPasswordText.resignFirstResponder()
        }
        return true
    }
}
