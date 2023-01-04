//
//  Utils.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 04/01/23.
//

import Foundation

class Utils {
    static func saveUserDefaults(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func removeUserDefaults(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func getUserDefaults(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
