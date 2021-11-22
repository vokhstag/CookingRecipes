//
//  ModelBuilder.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainController(router: MainRouterProtocol) -> UIViewController
    func createFavoriteFoodController() -> UIViewController
    func createDetailController(dish: Dish) -> UIViewController
    func createAuthorizationModule() -> UIViewController
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
    func createFavoriteFoodController() -> UIViewController {
        let view = FavoriteFoodViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
    func createDetailController(dish: Dish) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(dish: dish)
        view.presenter = presenter
        return view
    }
    func createAuthorizationModule() -> UIViewController {
        let view = AuthorizationViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
}
