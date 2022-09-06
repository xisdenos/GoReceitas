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
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
                CellsInfoSections(categoryName: "Mexicana"),
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
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
            ]
        )
    }()
    
    private let popular: Sections = {
        .popular(
            [
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Lasanha", prepTime: "60min", foodImage: "lasanha"),
            ]
        )
    }()
    
    var data: [Sections] {
        [categories, tryItOut, popular]
    }
}
