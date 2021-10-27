//
//  TabBarRouter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

protocol TabBarRouterProtocol: BaseRouter {
    
}

class TabBarRouter: TabBarRouterProtocol {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    
}
