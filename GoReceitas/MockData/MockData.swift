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
                CategoryModel(categoryName: "Japanese"),
                CategoryModel(categoryName: "Healthy"),
                CategoryModel(categoryName: "Snacks"),
                CategoryModel(categoryName: "Indian"),
                CategoryModel(categoryName: "Taiwan"),
                CategoryModel(categoryName: "Italian"),
                CategoryModel(categoryName: "Middle Eastern"),
                CategoryModel(categoryName: "Breakfast"),
                CategoryModel(categoryName: "Barbecue"),
                CategoryModel(categoryName: "Vegan"),
            ]
        )
    }()
    
    private let tryItOut: Sections = {
        .tryItOut(
            [
                CellsInfoSections(foodName: "Pizza chicago", prepTime: "35 min", foodImage: "pizza-chicago"),
                CellsInfoSections(foodName: "Mac-and-cheese", prepTime: "40 min", foodImage: "mac-and-cheese"),
                CellsInfoSections(foodName: "Oats", prepTime: "10 min", foodImage: "oats"),
                CellsInfoSections(foodName: "Pumpkin-pie", prepTime: "60min", foodImage: "pumpkin-pie"),
                CellsInfoSections(foodName: "Croissant", prepTime: "60 min", foodImage: "croissant-breakfast-pizza"),
                CellsInfoSections(foodName: "Rice", prepTime: "20 min", foodImage: "rice"),
            ]
        )
    }()
    
    private let popular: Sections = {
        .popular(
            [
                CellsInfoSections(foodName: "Shrimp", prepTime: "30 min", foodImage: "shrimp"),
                CellsInfoSections(foodName: "Tomato", prepTime: "10 min", foodImage: "tomato"),
                CellsInfoSections(foodName: "Birria tacos", prepTime: "25 min", foodImage: "birria-tacos"),
                CellsInfoSections(foodName: "Croissant", prepTime: "45 min", foodImage: "croissant-breakfast-pizza"),
                CellsInfoSections(foodName: "Grilled tacos", prepTime: "20 min", foodImage: "grilled-tacos"),
                CellsInfoSections(foodName: "Lasagna", prepTime: "60 min", foodImage: "lasanha"),
                CellsInfoSections(foodName: "Spaghetti", prepTime: "20 min", foodImage: "macarrao"),
            ]
            
        )
    }()
    
    var data: [Sections] {
        [categories, tryItOut, popular]
    }
}
