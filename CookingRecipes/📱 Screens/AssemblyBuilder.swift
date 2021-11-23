//
//  ModelBuilder.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainController(router: MainRouterProtocol) -> UIViewController
    func createFavoriteFoodController(router: FavoriteFoodRouterProtocol,
                                      dataManager: DishesDataManagerProtocol) -> UIViewController
    func createDetailController(dish: Dish,
                                dataManager: DishesDataManagerProtocol,
                                router: BaseRouter) -> UIViewController
    func createAuthorizationController(dataManager: UserDataManagerProtocol) -> UIViewController
    func createIngredientController(url: URL?, name: String, measure: String?) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    private let categoriesnetworkService = CategoriesNetworkService()
    private let recipesNetworkService = RecipesNetworkService()
    func createMainController(router: MainRouterProtocol) -> UIViewController {
        let contentViewController = MainViewController()
        let contentPresenter = MainPresenter(view: contentViewController,
                                             networkService: recipesNetworkService,
                                             router: router)
        contentViewController.presenter = contentPresenter
        let view = MainContainerViewController()
        let presenter = MainContainerPresenter(view: view, network: categoriesnetworkService)
        presenter.delegate = contentPresenter
        view.presenter = presenter
        view.contentViewController = contentViewController
        return view
    }
    func createFavoriteFoodController(router: FavoriteFoodRouterProtocol,
                                      dataManager: DishesDataManagerProtocol) -> UIViewController {
        let view = FavoriteFoodViewController()
        let presenter = FavoriteFoodPresenter(router: router, dishesDataManager: dataManager)
        view.presenter = presenter
        return view
    }
    func createDetailController(dish: Dish,
                                dataManager: DishesDataManagerProtocol,
                                router: BaseRouter) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, router: router, dish: dish, dishesDataManager: dataManager)
        view.presenter = presenter
        return view
    }
    func createAuthorizationController(dataManager: UserDataManagerProtocol) -> UIViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view,
                                               dataManager: dataManager)
        view.presenter = presenter
        return view
    }
    func createIngredientController(url: URL?, name: String, measure: String?) -> UIViewController {
        let view = IngredientViewController()
        let presenter = IngredientPresenter(imageURL: url, name: name, measure: measure)
        view.presenter = presenter
        return view
    }
}
