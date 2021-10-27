//
//  ModelBuilder.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController
    func createFavoriteFoodModule() -> UIViewController
    func createAuthorizationModule() -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createAuthorizationModule() -> UIViewController {
        let view = AuthorizationViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
}
