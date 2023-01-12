//
//  LoginViewModel.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 12/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol LoginViewModelDelegate: AnyObject {
    func showAlert(title: String, message: String)
    func signInUser()
}

final class LoginViewModel {
    
    let database = Database.database().reference()
    
    var auth: Auth?
    
    init() {
        self.auth = Auth.auth()
    }
    
    weak var delegate: LoginViewModelDelegate?
    
    func createUser(email: String, password: String) {
        auth?.signIn(withEmail: email, password: password, completion: { [weak self] usuario, error in
            if error != nil {
                self?.delegate?.showAlert(title: "Heads up", message: "Incorrect data, try again")
            } else {
                if usuario == nil {
                    self?.delegate?.showAlert(title: "Heads up", message: "We had an unexpected problem")
                } else {
                    self?.delegate?.signInUser()
                }
            }
        })
    }
}
