//
//  Favorite.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 30/12/22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct Favorite {
    static func unfavoriteItem(at food: FoodResponse, database: DatabaseReference) {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else { return }
            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
            
            database.child("users/\(emailFormatted)").child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                if var value = snapshot.value as? [String: Any] {
                    for (key, _) in value {
                        if key == String(food.id) {
                            // Create a dictionary with the additional information
                            let userInfo: [String: Any] = [
                                "favoriteId": key
                            ]
                            // Post the notification with the userInfo dictionary
                            NotificationCenter.default.post(name: .favoritesUpdated, object: nil, userInfo: userInfo)
                            
                            value.removeValue(forKey: key)
                            
                            database.child("users/\(emailFormatted)").child("favorites").setValue(value)
                            break
                        }
                    }
                }
            })
        } else {
            print("There is no currently signed-in user.")
        }
    }
    
    static var getCurrentUserEmail: String {
        if let user = Auth.auth().currentUser {
            if let email = user.email {
                let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                return emailFormatted
            }
        }
        return ""
    }
}
