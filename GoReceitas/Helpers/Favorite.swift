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
    private var isActiveHeart = false
    
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
    
    static func unfavoriteItem(by id: Int, database: DatabaseReference) {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else { return }
            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
            
            database.child("users/\(emailFormatted)").child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                if var value = snapshot.value as? [String: Any] {
                    for (key, _) in value {
                        if key == String(id) {
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
    
    static func favoriteItem(itemSelected: FoodResponse, favorited: Bool, database: DatabaseReference) {
        let userEmail = Favorite.getCurrentUserEmail
        
        let favArray: [FoodResponse] = [FoodResponse(id: itemSelected.id, name: itemSelected.name, thumbnail_url: itemSelected.thumbnail_url, cook_time_minutes: itemSelected.cook_time_minutes ?? 0, prep_time_minutes: itemSelected.prep_time_minutes ?? 0, yields: itemSelected.yields ?? "n/a")]
        
        let mappedArray = favArray.map { ["name": $0.name, "yields": $0.yields ?? "n/a", "image": $0.thumbnail_url, "isFavorited": favorited, "id": $0.id, "cook_time_minutes": $0.cook_time_minutes ?? 0, "prep_time_minutes": $0.prep_time_minutes ?? 0] }
        
        // create a dictionary of arrays with the key being food.name
        let dictionary = Dictionary(uniqueKeysWithValues: mappedArray.map { ($0["name"] as! String, $0) })
        
        // database.child("users/\(userEmail)").child("favorites").child(String(itemSelected.id)).updateChildValues(dictionary)
        database.child("users/\(userEmail)").child("favorites").child(String(itemSelected.id)).setValue(dictionary)
    }
}
