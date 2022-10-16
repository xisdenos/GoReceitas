//
//  Login.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 8/28/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            guard error == nil, let user = authDataResult else {
                return
            }
            let result = user.user
            print("user logged in succesfully \(result)")
        }
    }
    
    
    @IBAction func tappedGoogleSignInButton(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let signInConfig = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            
            guard let authentication = user?.authentication,
                  let tokenID = authentication.idToken else { return }
            
            let credentials = GoogleAuthProvider.credential(withIDToken: tokenID, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credentials) { authDataResult, error in
                guard error == nil else { return }
                
                print("SIGN IN SUCCESSFULLY!")
            }
        }
    }
}
