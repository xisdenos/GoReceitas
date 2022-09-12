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
                CellsInfoSections(categoryName: "Chinesa"),
                CellsInfoSections(categoryName: "Indiana"),
                CellsInfoSections(categoryName: "Saudável"),
                CellsInfoSections(categoryName: "Vegetariana"),
                CellsInfoSections(categoryName: "Lanches"),
                CellsInfoSections(categoryName: "Café da manhã"),
                CellsInfoSections(categoryName: "Sobremesa"),
                CellsInfoSections(categoryName: "Petisco"),
                CellsInfoSections(categoryName: "Bebida"),
                CellsInfoSections(categoryName: "Salada"),
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
