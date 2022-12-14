//
//  changeEmailViewController.swift
//  GoReceitas
//
//  Created by Lorena on 08/09/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChangeEmailViewController: UIViewController {
    
    //    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var newEmailText: UITextField!
    @IBOutlet weak var currentPasswordText: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var auth: Auth?
    var alert: AlertController?
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        configFontAndColors()
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
        changeEmail()
    }
    
    func changeEmail () {
        let db = Firestore.firestore()
//        let userID = Auth.auth().currentUser?.uid
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        let currentEmail = Favorite.getCurrentUserEmail

        if newEmailText.text != nil {
            db.collection("usuarios").document(currentEmail).updateData(["email": newEmailText.text ?? "" ])
            if newEmailText.text != userEmail {
                currentUser?.updateEmail(to: newEmailText.text ?? "") {error in
                    if let error = error {
                        print(error)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func configFontAndColors(){
        confirmButton.isEnabled = false
        
        newEmailText.layer.cornerRadius = 10
        currentPasswordText.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
        newEmailText.delegate = self
        currentPasswordText.delegate = self
        
    }
    
    func alertVerification(){
        if newEmailText.text == "" || currentPasswordText.text == "" {
            self.alert?.alertInformation(title: "Heads up", message: "Invalid email or password", completion: {
                self.navigationController?.popViewController(animated: true)
            })
            
            
        }else{
            self.alert?.alertInformation(title: "Success", message: "Email changed successfully", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
}

extension ChangeEmailViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if newEmailText.text == "" || currentPasswordText.text == "" {
            confirmButton.isEnabled = false
        }else{
            confirmButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(self.newEmailText){
            self.newEmailText.becomeFirstResponder()
            self.currentPasswordText.becomeFirstResponder()
        }else{
            self.currentPasswordText.resignFirstResponder()
        }
        return true
    }
}
