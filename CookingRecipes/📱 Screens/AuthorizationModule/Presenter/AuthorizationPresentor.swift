//
//  AuthorizationPresentor.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 23.11.2021.
//

import Foundation

protocol AuthorizationViewProtocol: class {
    func succes()
    func failure(errorDescription: String)
}

protocol AuthorizationPresenterProtocol {
    func createNewUser(name: String, login: String, password: String)
}

class AuthorizationPresenter {
    private weak var view: AuthorizationViewProtocol?
    private let dataManager: UserDataManagerProtocol
    // MARK: - Constructor
    init(view: AuthorizationViewProtocol, dataManager: UserDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}
//
extension AuthorizationPresenter: AuthorizationPresenterProtocol {
    func createNewUser(name: String, login: String, password: String) {
        let result = dataManager.createUser(name: name, login: login, password: password)
        if result {
            view?.succes()
        } else {
            view?.failure(errorDescription: "Не удалось зарегистрироваться")
        }
    }
}
