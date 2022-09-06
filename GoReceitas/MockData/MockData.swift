//
//  MockData.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/09/22.
//

import Foundation

class MockData {
    static let shared = MockData()
    
    private let categories: CategorySection = {
        .category(
            [
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
                CategoryModel(categoryName: "Mexicana"),
            ]
        )
    }()
    
    var data: [CategorySection] {
        [categories]
    }
}
