//
//  RecipesNetworkService.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 15.11.2021.
//

import Foundation

typealias RecipesResponse = Result<[Dish], NetworkServiceError>

protocol RecipesNetworkServiceProtocol {
    func getDishes(url: URL, completion: @escaping (RecipesResponse) -> Void)
}

class RecipesNetworkService: BaseNetworkService, RecipesNetworkServiceProtocol {
    func getDishes(url: URL, completion: @escaping (RecipesResponse) -> Void) {
        let handler: Handler = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                let response = try self.decoder.decode(Meals.self, from: data)
                completion(.success(response.meals))
            } catch {
                completion(.failure((error as? NetworkServiceError) ?? .decode))
            }
        }

        session.dataTask(with: url, completionHandler: handler).resume()
    }
}
