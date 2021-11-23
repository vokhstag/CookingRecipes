//
//  DetailPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import Foundation

protocol DetailViewProtocol: class {
    func dishRemovedFromFavorite()
    func dishAddedToFavorite()
    func failure(errorDescription: String)
}

protocol DetailPresenterType {
    var dish: Dish { get }
    func saveDish()
    func removeDishFromFavorite()
    func isFavoriteDish() -> Bool
}

class DetailPresenter: DetailPresenterType {
    var dish: Dish
    private weak var view: DetailViewProtocol?
    private let dishesDataManager: DishesDataManagerProtocol
    init(view: DetailViewProtocol, dish: Dish, dishesDataManager: DishesDataManagerProtocol) {
        self.view = view
        self.dish = dish
        self.dishesDataManager = dishesDataManager
    }
    func saveDish() {
        if dishesDataManager.saveDish(dish: dish) {
            self.view?.dishAddedToFavorite()
        } else {
            self.view?.failure(errorDescription: "Не удалось добавить в избранное")
        }
    }
    func removeDishFromFavorite() {
        if self.dishesDataManager.deleteDishBy(id: dish.id) {
            self.view?.dishRemovedFromFavorite()
        } else {
            self.view?.failure(errorDescription: "Блюдо не добавлено в избранное")
        }
    }
    func isFavoriteDish() -> Bool {
        return self.dishesDataManager.dishBy(id: dish.id) != nil
    }
}
