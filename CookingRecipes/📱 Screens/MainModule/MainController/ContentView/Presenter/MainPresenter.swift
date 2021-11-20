//
//  MainPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func succes()
    func failure(errorDescription: String)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: RecipesNetworkServiceProtocol, router: MainRouterProtocol)
    var dishes: [Dish] {get set}
    func getListOfDishes(url: URL)
    func goToDetailRecipe(dish: Dish)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: RecipesNetworkServiceProtocol
    var router: MainRouterProtocol?
    var dishes: [Dish] = []
    required init(view: MainViewProtocol, networkService: RecipesNetworkServiceProtocol, router: MainRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
      //  getListOfDishes(url: )
    }
    func getListOfDishes(url: URL) {
        networkService.getDishes(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dishes):
                self.dishes = dishes
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(errorDescription: error.localizedDescription)
            }
        }
    }
    func goToDetailRecipe(dish: Dish) {
        router?.showRecipeController(dish: dish)
    }
}

extension MainPresenter: UpdateContentProtocol {
    func update(with category: String) {
        let recipesUrl = Endpoints.recipes(category: category).url
        guard let url = recipesUrl else {
            view?.failure(errorDescription: "Не правильный URL адрес")
            return
        }
        getListOfDishes(url: url)
    }
}
