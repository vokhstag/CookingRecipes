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

protocol MainContainerPresenterType {
    var categories: [Category] { get }
    func getCategories()
}

class MainContainerPresenter: MainContainerPresenterType {
    var categories: [Category] = []
    // MARK: - Private Properties
    private weak var view: MainContainerViewProtocol?
    private var network: CategoriesNetworkServiceProtocol
    private let endpoint = Endpoints.categories
    init(view: MainContainerViewProtocol?, network: CategoriesNetworkServiceProtocol) {
        self.view = view
        self.network = network
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
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(errorDescription: error.message)
            }
        }
    }
}
