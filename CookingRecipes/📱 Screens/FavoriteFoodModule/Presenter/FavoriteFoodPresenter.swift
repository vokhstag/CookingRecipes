//
//  FavoriteFoodPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 23.11.2021.
//

import Foundation

protocol FavoriteFoodPresenterProtocol {
    var dishes: [FavoriteFood] { get }
    func goToDetailRecipe(dish: FavoriteFood)
}

class FavoriteFoodPresenter: FavoriteFoodPresenterProtocol {
    var dishes: [FavoriteFood] {
        return dishesDataManager.getDishes()
    }
    private let dishesDataManager: DishesDataManagerProtocol
    private let router: FavoriteFoodRouterProtocol
    init(router: FavoriteFoodRouterProtocol, dishesDataManager: DishesDataManagerProtocol) {
        self.dishesDataManager = dishesDataManager
        self.router = router
    }
    func goToDetailRecipe(dish: FavoriteFood) {
        router.showDetailController(dish: dish.getDish())
    }
}
