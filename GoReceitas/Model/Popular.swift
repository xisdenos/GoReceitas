//
//  Popular.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 24/12/22.
//

import Foundation

struct Popular: Codable {
    var results: [PopularResponse]?
}

struct PopularResponse: Codable {
    var item: PopularResponseDetails?
}

struct PopularResponseDetails: Codable {
    var recipes: [FoodResponse]?
}
