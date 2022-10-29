//
//  Sections.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/09/22.
//

import Foundation

enum Sections {
    case categories([CellsInfoSections])
    case tryItOut([CellsInfoSections])
    case popular([CellsInfoSections])
    
        var items: [CellsInfoSections] {
            switch self {
            case .categories(let array):
                return array
            case .tryItOut(let array):
                return array
            case .popular(let array):
                return array
            }
        }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .categories:
            return "Categories"
        case .tryItOut:
            return "Try it out"
        case .popular:
            return "Popular"
        }
    }
}
