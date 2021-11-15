//
//  MainPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: MainRouterProtocol)
    var dishes: [Dish]? {get set}
    func getListOfDishes()
    func goToDetailRecipe(dish: Dish)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: MainRouterProtocol?
    var dishes: [Dish]?
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: MainRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getListOfDishes()
    }
    func getListOfDishes() {
        networkService.getDishes { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    self.dishes = dishes?.meals
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    func goToDetailRecipe(dish: Dish) {
        router?.showRecipeController(dish: dish)
    }
}
