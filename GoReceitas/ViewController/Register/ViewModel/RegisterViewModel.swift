//
//  RegisterViewModel.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 12/01/23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase
import FirebaseFirestore

protocol RegisterViewModelDelegate: AnyObject {
    func showAlert(title: String, message: String, completion: (() -> Void)?)
    func signUp()
}

final class RegisterViewModel {
    
    private var firestore: Firestore?
    private var user = Auth.auth().currentUser
    private var auth: Auth?
    
    init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    weak var delegate: RegisterViewModelDelegate?
    
    func createUserWith(_ name: String, _ email: String, _ password: String, _ passwordConfirmation: String) {
        if password == passwordConfirmation {
            self.auth?.createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                if error != nil{
                    self?.delegate?.showAlert(title: "Heads up", message: "Error registering, check the data and try again", completion: nil)
                } else {
                    
                    let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                    let userRef = self?.firestore?.collection("usuarios").document(emailFormatted)
                    
                    userRef?.getDocument { snapshot, error in
                        guard let snapshot else { return }
                        if !snapshot.exists {
                            userRef?.setData([
                                "nome": name,
                                "email": email
                            ]) { error in
                                if error != nil {
                                    print("Error writing document: (error.localizedDescription)")
                                } else {
                                    print("User data successfully written to Firestore!")
                                }
                            }
                        }
                    }
                    
                    self?.delegate?.showAlert(title: "Success", message: "Successfully registered user", completion: {
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            // igor-gmail-com
                            let database = Database.database().reference()
                            let data = ["name": name, "email": email]
                            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                            database.child("users").child(emailFormatted).setValue(data)
                        }
                        
                        self?.delegate?.signUp()
                    })
                }
            })
        } else {
            self.delegate?.showAlert(title: "Heads up", message: "Divergent Passwords", completion: nil)
        }
    }
}
