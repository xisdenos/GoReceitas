//
//  MockData.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/09/22.
//

import Foundation

class MockData {
    static let shared = MockData()
    
    private let categories: Sections = {
        .categories(
            [
                CellsInfoSections(categoryName: "Japanese"),
                CellsInfoSections(categoryName: "Healthy"),
                CellsInfoSections(categoryName: "Snacks"),
                CellsInfoSections(categoryName: "Indian"),
                CellsInfoSections(categoryName: "Taiwan"),
                CellsInfoSections(categoryName: "Italian"),
                CellsInfoSections(categoryName: "Middle Eastern"),
                CellsInfoSections(categoryName: "Breakfast"),
                CellsInfoSections(categoryName: "Barbecue"),
                CellsInfoSections(categoryName: "Vegan"),
            ]
        )
    }()
    
    private let tryItOut: Sections = {
        .tryItOut(
            [
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
            ]
        )
    }()
    
    private let popular: Sections = {
        .popular(
            [
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
                CellsInfoSections(foodName: "Macarrão", prepTime: "40min", foodImage: "macarrao"),
            ]
            
        )
    }()
    
    var data: [Sections] {
        [categories, tryItOut, popular]
    }
}
