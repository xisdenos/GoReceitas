//
//  ViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 19/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var buttonChangePassword: UIButton!
    @IBOutlet weak var buttonGoOut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageRound()
        exitButtonBorder()
        cornerRadiusElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tapChangePasswordScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "changePassword")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapChangeEmailScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "changeEmail")
        navigationController?.pushViewController(viewController, animated: true)
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

    









































