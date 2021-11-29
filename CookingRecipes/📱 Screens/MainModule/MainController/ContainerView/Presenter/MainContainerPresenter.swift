//
//  MainContainerPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 16.11.2021.
//

import Foundation

protocol MainContainerViewProtocol: class {
    func succes()
    func failure(errorDescription: String)
}

protocol UpdateContentProtocol: class {
    func update(with category: String)
    func update(withSearchText text: String)
}

protocol MainContainerPresenterType {
    var selectedCategoryName: String { get set }
    var categories: [Category] { get }
    func getCategories()
    func searchByName(text: String)
    func getUserName() -> String
}

class MainContainerPresenter: MainContainerPresenterType {
    var selectedCategoryName: String {
        get {
            return self.defaults.string(forKey: Keys.kSelectedCategory) ?? ""
        }
        set {
            defaults.setValue(newValue, forKey: Keys.kSelectedCategory)
            self.delegate?.update(with: newValue)
        }
    }
    var categories: [Category] = []
    // MARK: DI
    weak var delegate: UpdateContentProtocol?
    // MARK: - Private Properties
    private weak var view: MainContainerViewProtocol?
    private var network: CategoriesNetworkServiceProtocol
    private let endpoint = Endpoints.categories
    private let defaults = UserDefaults.standard
    private let userDataManager: UserDataManagerProtocol
    // MARK: - Constructor
    init(view: MainContainerViewProtocol?,
         network: CategoriesNetworkServiceProtocol,
         userDataManager: UserDataManagerProtocol) {
        self.view = view
        self.network = network
        self.userDataManager = userDataManager
    }
    func getCategories() {
        guard let url = endpoint.url else {
            self.view?.failure(errorDescription: "Не правильный URL")
            return
        }
        network.getCategories(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories
                if !categories.isEmpty {
                    let name = self.defaults.string(forKey: Keys.kSelectedCategory) ?? categories[0].name
                    self.selectedCategoryName = name
                    self.delegate?.update(with: name)
                }
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(errorDescription: error.message)
            }
        }
    }
    func searchByName(text: String) {
        self.delegate?.update(withSearchText: text)
    }
    func getUserName() -> String {
        return userDataManager.getActiveUser()?.name ?? ""
    }
}
