//
//  MainRouter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

protocol MainRouterProtocol: BaseRouter {
    func initialViewController()
    func showDetailController(dish: Dish)
    func showAuthorizationControllerIfNeed()
    func showIngredientController(url: URL?, name: String, measure: String?)
}

class MainRouter: MainRouterProtocol {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol?
    private var userDataManager: UserDataManagerProtocol
    private var dishesDataManager: DishesDataManagerProtocol
    // MARK: - Constructor
    init(tabBarController: UITabBarController?,
         navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol?,
         userDataManager: UserDataManagerProtocol,
         dishesDataManager: DishesDataManagerProtocol) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.userDataManager = userDataManager
        self.dishesDataManager = dishesDataManager
    }
    func initialViewController() {
        guard let mainViewController = assemblyBuilder?.createMainController(router: self) else { return }
        mainViewController.tabBarItem = UITabBarItem(title: "Home",
                                                     image: UIImage.TabBarIcons.home,
                                                     selectedImage: UIImage.TabBarIcons.homeSelected)
        navigationController.viewControllers = [mainViewController]
    }
    func showDetailController(dish: Dish) {
        guard let detailViewController = assemblyBuilder?.createDetailController(dish: dish,
                                                                                 dataManager: dishesDataManager, router: self)
        else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    func showAuthorizationControllerIfNeed() {
        guard userDataManager.getActiveUser() == nil else { return }
        guard let authorizationController =
                assemblyBuilder?.createAuthorizationController(dataManager: self.userDataManager)
        else { return }
        authorizationController.modalPresentationStyle = .fullScreen
        self.navigationController.present(authorizationController, animated: true)
    }
    func showIngredientController(url: URL?, name: String, measure: String?) {
        guard let ingredientViewContrroller = assemblyBuilder?.createIngredientController(url: url,
                                                                                          name: name,
                                                                                          measure: measure)
        else { return }
        self.navigationController.present(ingredientViewContrroller, animated: true)
    }
}
