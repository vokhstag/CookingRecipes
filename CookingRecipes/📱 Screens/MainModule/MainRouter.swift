//
//  MainRouter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

protocol MainRouterProtocol: BaseRouter {
    func initialViewController()
    func showRecipeController(dish: Dish)
}

class MainRouter: MainRouterProtocol {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol?
    init(tabBarController: UITabBarController?,
         navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol?) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func initialViewController() {
        guard let mainViewController = assemblyBuilder?.createMainController(router: self) else { return }
        mainViewController.tabBarItem = UITabBarItem(title: "Home",
                                                     image: UIImage.TabBarIcons.home,
                                                     selectedImage: UIImage.TabBarIcons.homeSelected)
        navigationController.viewControllers = [mainViewController]
    }
    func showRecipeController(dish: Dish) {
        guard let detailViewController = assemblyBuilder?.createRecipeController() else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
