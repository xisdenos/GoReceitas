//
//  DefaultCellsDelegate.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 29/11/22.
//

import Foundation

protocol DefaultCellsDelegate: AnyObject {
    func didTapDefaultFoodCell(food: FoodResponse)
    func didFavoriteItem(itemSelected: FoodResponse, favorited: Bool)
}

extension DefaultCellsDelegate {
    func didFavoriteItem(itemSelected: FoodResponse, favorited: Bool) {}
}
