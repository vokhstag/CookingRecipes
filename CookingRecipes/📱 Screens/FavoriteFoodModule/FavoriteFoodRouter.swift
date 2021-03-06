//
//  FavoriteFoodRouter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

protocol FavoriteFoodRouterProtocol: BaseRouter {
    func initialViewController()
    func showDetailController(dish: Dish)
    func showIngredientController(url: URL?, name: String, measure: String?)
}

class FavoriteFoodRouter: FavoriteFoodRouterProtocol {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol?
    private var dishesDataManager: DishesDataManagerProtocol
    init(tabBarController: UITabBarController?,
         navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol?,
         dishesDataManager: DishesDataManagerProtocol) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.dishesDataManager = dishesDataManager
    }
    func initialViewController() {
        guard let mainViewController = assemblyBuilder?.createFavoriteFoodController(router: self,
                                                                                     dataManager: dishesDataManager)
        else { return }
        mainViewController.tabBarItem = UITabBarItem(title: "Favorite",
                                                     image: UIImage.TabBarIcons.bookmark,
                                                     selectedImage: UIImage.TabBarIcons.bookmarkSelected)
        navigationController.viewControllers = [mainViewController]
    }
    func showDetailController(dish: Dish) {
        guard let detailViewController = assemblyBuilder?.createDetailController(dish: dish,
                                                                                 dataManager: dishesDataManager,
                                                                                 router: self)
        else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    func showIngredientController(url: URL?, name: String, measure: String?) {
        guard let ingredientViewContrroller = assemblyBuilder?.createIngredientController(url: url,
                                                                                          name: name,
                                                                                          measure: measure)
        else { return }
        self.navigationController.present(ingredientViewContrroller, animated: true)
    }
}
