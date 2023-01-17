//
//  LoginViewModel.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 12/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore

protocol LoginViewModelDelegate: AnyObject {
    func showAlert(title: String, message: String)
    func signInUser()
}

protocol LoginViewModelProtocol {
    func login(email: String, password: String)
    func loginWithGoogle(presentingViewController: UIViewController)
}

struct LoginViewModel: LoginViewModelProtocol {
    
    private let database = Database.database().reference()
    private weak var delegate: LoginViewModelDelegate?
    private var auth: Auth?
    public var isLoginSuccesful = false
    
    init() {
        self.auth = Auth.auth()
    }
    
    public mutating func set(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func login(email: String, password: String) {
        auth?.signIn(withEmail: email, password: password, completion: { usuario, error in
            if error != nil {
                delegate?.showAlert(title: "Heads up", message: "Incorrect data, try again")
            } else {
                if usuario == nil {
                    delegate?.showAlert(title: "Heads up", message: "User does not exist")
                } else {
                    delegate?.signInUser()
                }
            }
        })
    }
    
    func loginWithGoogle(presentingViewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!

        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { user, error in
            
            guard error == nil else {
                self.delegate?.showAlert(title: "Heads up", message: "Failed to login, please try again!")
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { dataResult, error in
                guard error == nil else {
                    delegate?.showAlert(title: "Heads up", message: "Failed to login, please try again!")
                    return
                }
                
                // igor-gmail-com
                let email = dataResult?.user.email ?? "no-email"
                let name = dataResult?.user.displayName ?? "Username"
                let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                
                let firestore = Firestore.firestore()
                let userRef = firestore.collection("usuarios").document(emailFormatted)
                // image google pfp
                guard let pfp = user?.profile?.imageURL(withDimension: 100) else { return }
                let urlString = pfp.absoluteString
                
                userRef.getDocument { snapshot, error in
                    guard let snapshot else { return }
                    if !snapshot.exists {
                        guard let name = user?.profile?.name else { return }
                        guard let email = user?.profile?.email else { return }
                        userRef.setData([
                            "nome": name,
                            "email": email,
                            "image": urlString,
                        ]) { error in
                            if let error = error {
                                print("Error writing document: \(error.localizedDescription)")
                            } else {
                                print("User data successfully written to Firestore!")
                            }
                        }
                    }
                }
                
                // if there is no user, set all the new data.
                database.child("users").observeSingleEvent(of: .value) { snapshot in
                    if !snapshot.hasChild(emailFormatted) {
                        let data = ["name": name, "email": email]
                        database.child("users").child(emailFormatted).setValue(data)
                    }
                }
                delegate?.signInUser()
            }
        }
    }
}
