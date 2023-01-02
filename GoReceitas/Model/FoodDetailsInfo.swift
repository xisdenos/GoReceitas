//
//  FoodDetailsInfo.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 10/12/22.
//

import Foundation

struct FoodDetailsInfo: Codable {
    let id: Int
    let name: String
    let cook_time_minutes, prep_time_minutes: Int?
    let yields: String?
    let thumbnail_url: String
    let nutrition: Nutrition?
    let instructions: [Instruction]?
}

struct Instruction: Codable {
    var display_text: String
}

struct Nutrition: Codable {
    let calories: Int?
    let carbohydrates: Int?
    let fat: Int?
    let protein: Int?
}
