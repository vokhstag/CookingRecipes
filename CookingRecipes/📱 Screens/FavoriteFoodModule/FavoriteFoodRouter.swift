//
//  FavoriteFoodRouter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

protocol FavoriteFoodRouterProtocol: BaseRouter {
}

class FavoriteFoodRouter: FavoriteFoodRouterProtocol {
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
        guard let mainViewController = assemblyBuilder?.createFavoriteFoodController() else { return }
        mainViewController.tabBarItem = UITabBarItem(title: "Favorite",
                                                     image: UIImage.TabBarIcons.bookmark,
                                                     selectedImage: UIImage.TabBarIcons.bookmark)
        navigationController.viewControllers = [mainViewController]
    }
    func showRecipeController() {
        guard let detailViewController = assemblyBuilder?.createRecipeController() else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
