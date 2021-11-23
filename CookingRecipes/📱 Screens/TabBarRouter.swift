//
//  TabBarRouter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

protocol TabBarRouterProtocol {
}

class TabBarRouter: TabBarRouterProtocol {
    var tabBarController: UITabBarController?
//    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    init() {
        self.tabBarController = UITabBarController()
//        self.navigationController = navigationController
        self.assemblyBuilder = AssemblyBuilder()
    }
    func start() {
        let mainNavigationController = UINavigationController()
        let favoriteFoodNavigationController = UINavigationController()
        let userDataManager = UserDataManager()
        let mainRouter = MainRouter(tabBarController: self.tabBarController,
                                    navigationController: mainNavigationController,
                                    assemblyBuilder: self.assemblyBuilder, userDataManager: userDataManager)
        let favoriteFoodRouter = FavoriteFoodRouter(tabBarController: self.tabBarController,
                                                    navigationController: favoriteFoodNavigationController,
                                                    assemblyBuilder: self.assemblyBuilder)
        mainRouter.initialViewController()
        favoriteFoodRouter.initialViewController()
        self.tabBarController?.setViewControllers(
            [mainRouter.navigationController, favoriteFoodRouter.navigationController], animated: true)
    }
}
