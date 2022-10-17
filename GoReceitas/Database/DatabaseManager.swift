//
//  DatabaseManager.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 17/10/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    /// inserts new user into database
    public func insertNewUser(with user: User) {
        database.child(user.formattedEmail).setValue(["username": user.name])
        print("new user inserted successfully")
    }
    
    /// check if user exists based on it's email
//    public func checkIfUserAlreadyExists(with email: String, completion: @escaping ((Bool) -> Void)) {
//        var validEmail = email.replacingOccurrences(of: ".", with: "-")
//        validEmail = validEmail.replacingOccurrences(of: "@", with: "-")
//        
//        database.child(validEmail).observeSingleEvent(of: .value) { snapshot in
//            guard let _ = snapshot.value as? String else { return completion(true) }
//            completion(true)
//        }
//    }
}

