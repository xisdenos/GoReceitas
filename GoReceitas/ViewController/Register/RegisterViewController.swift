//
//  Cadastro.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 8/28/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard error == nil, let user = authDataResult else {
                print("something went wrong while creating a new account.")
                return
            }
            
            let result = user.user
            print(result)
        }
    }
}
