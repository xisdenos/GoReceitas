//
//  Foods.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/12/22.
//

import Foundation

struct Foods: Codable {
    var results: [FoodResponse]
}

struct FoodResponse: Codable {
    let id: Int
    let name: String
    let thumbnail_url: String
    let cook_time_minutes, prep_time_minutes: Int?
    // rendimento
    let yields: String?
}
