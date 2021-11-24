//
//  NetworkSevice.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

typealias CategoriesResponse = Result<[Category], NetworkServiceError>

protocol CategoriesNetworkServiceProtocol {
    func getCategories(url: URL, completion: @escaping (CategoriesResponse) -> Void)
}

class CategoriesNetworkService: BaseNetworkService, CategoriesNetworkServiceProtocol {
    func getCategories(url: URL, completion: @escaping (CategoriesResponse) -> Void) {
        let handler: Handler = { rawData, response, error in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                let response = try self.decoder.decode(Categories.self, from: data)
                completion(.success(response.categories))
            } catch {
                completion(.failure((error as? NetworkServiceError) ?? .decode))
            }
        }

        session.dataTask(with: url, completionHandler: handler).resume()
    }
}
