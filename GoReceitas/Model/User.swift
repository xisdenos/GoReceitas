//
//  User.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 17/10/22.
//

import Foundation

struct User {
    var email: String
    var name: String?
    
    var formattedEmail: String {
        var validEmail = email.replacingOccurrences(of: ".", with: "-")
        validEmail = validEmail.replacingOccurrences(of: "@", with: "-")
        return validEmail
    }
}
