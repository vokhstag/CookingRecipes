//
//  ModelBuilder.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

protocol Builder {
    static func createAuthorizationModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createAuthorizationModule() -> UIViewController {
        let view = AuthorizationViewController()
        // TODO: - Добавить презентер и настройки
        return view
    }
}
