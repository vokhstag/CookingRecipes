//
//  DetailPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import Foundation

protocol DetailPresenterType {
    var dish: Dish { get }
    func saveDish()
    func removeDishFromFavorite()
    func isFavoriteDish() -> Bool
}

class DetailPresenter: DetailPresenterType {
    var dish: Dish
    private let dishesDataManager: DishesDataManagerProtocol
    init(dish: Dish, dishesDataManager: DishesDataManagerProtocol) {
        self.dish = dish
        self.dishesDataManager = dishesDataManager
    }
    func saveDish() {
        dishesDataManager.saveDish(dish: dish)
    }
    func removeDishFromFavorite() {
        self.dishesDataManager.deleteDishBy(id: dish.id)
    }
    func isFavoriteDish() -> Bool {
        return self.dishesDataManager.dishBy(id: dish.id) != nil
    }
}
