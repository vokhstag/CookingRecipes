//
//  RecipesNetworkService.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 15.11.2021.
//

import Foundation

typealias RecipesResponse = Result<Meals, NetworkServiceError>

protocol RecipesNetworkServiceProtocol {
    func getDishes(url: URL, completion: @escaping (RecipesResponse) -> Void)
}

class RecipesNetworkService: BaseNetworkService, RecipesNetworkServiceProtocol {
    func getDishes(url: URL, completion: @escaping (RecipesResponse) -> Void) {
    }
}
