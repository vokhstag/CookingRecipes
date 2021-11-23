//
//  IngredientPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 23.11.2021.
//

import Foundation

protocol IngredientPresenterProtocol {
    var imageURL: URL? { get }
    var name: String { get }
    var measure: String? { get }
}

class IngredientPresenter: IngredientPresenterProtocol {
    var imageURL: URL?
    var name: String
    var measure: String?
    
    init(imageURL: URL?, name: String, measure: String?) {
        self.imageURL = imageURL
        self.name = name
        self.measure = measure
    }
}
