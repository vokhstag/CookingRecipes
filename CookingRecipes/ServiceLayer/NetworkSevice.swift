//
//  NetworkSevice.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getDishes(completion: @escaping (Result<Meals?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getDishes(completion: @escaping (Result<Meals?, Error>) -> Void) {
        let urlString = "https://themealdb.com/api/json/v1/1/search.php?s=Arrabiata"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(Meals.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
