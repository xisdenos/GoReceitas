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
        guard let userName = nameTextField.text else { return }
        guard let email = emailTextField.text, !email.isEmpty, email.count > 3 else { return print("incorrect format email") }
        guard let password = passwordTextField.text, !password.isEmpty, password.count > 3 else { return print("incorrect format password") }
        guard let passwordConfirmation = passwordConfirmationTextField.text else { return }
        
        
        if password == passwordConfirmation {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
                guard error == nil, let user = authDataResult else {
                    print("email already taken.")
                    return
                }
                
                let result = user.user
                print(result)
                DispatchQueue.global(qos: .background).async {
                    DatabaseManager.shared.insertNewUser(with: User(email: email, name: userName))
                }
            }
        } else {
            print("no match")
        }
    }
}


