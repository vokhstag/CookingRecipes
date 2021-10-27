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
    func createRecipeController() -> UIViewController
    func createAuthorizationModule() -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    private let networkService = NetworkService()
    func createMainController(router: MainRouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view,
                                      networkService: networkService,
                                      router: router)
        view.presenter = presenter
        return view
    }
    func createFavoriteFoodController() -> UIViewController {
        let view = FavoriteFoodViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
    func createRecipeController() -> UIViewController {
        let view = RecipeViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
    func createAuthorizationModule() -> UIViewController {
        let view = AuthorizationViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
}
