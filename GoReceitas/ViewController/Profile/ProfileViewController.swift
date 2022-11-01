//
//  ViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 19/08/22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var buttonChangePassword: UIButton!
    @IBOutlet weak var buttonGoOut: UIButton!
    
    var auth:Auth?
    var alert: AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        imageRound()
        exitButtonBorder()
        cornerRadiusElements()
        self.view.backgroundColor = .viewBackgroundColor
//        self.tabBarController?.tabBar.isHidden = false
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
   
    override func viewWillDisappear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = true
    }
  
    
    
    @IBAction func tapChangePasswordScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "changePassword") as! ChangePasswordViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapChangeEmailScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "changeEmail")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func tappedExit(_ sender: UIButton) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defauts = UserDefaults.standard
            defauts.set(false, forKey: "isUserSignedIn ")
            self.dismiss(animated: true,completion: nil)
        } catch let singOutError {
            self.alert?.alertInformation(title: "Atenção", message: "Erro ao Sair")
        }
        
        
        let vc = UIStoryboard(name: "LoginVC", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func imageRound() {
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius =  75
    }
    
    func cornerRadiusElements(){
        textUsername.layer.cornerRadius = 10
        textEmail.layer.cornerRadius = 10
        changeEmailButton.layer.cornerRadius = 10
        buttonChangePassword.layer.cornerRadius = 10
    }
    
    func exitButtonBorder() {
        buttonGoOut.backgroundColor = .clear
        buttonGoOut.layer.cornerRadius = 10
        buttonGoOut.layer.borderWidth = 1
        buttonGoOut.layer.borderColor = UIColor.red.cgColor
    }
}
