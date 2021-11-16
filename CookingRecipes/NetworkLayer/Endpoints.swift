//
//  Endpoints.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 15.11.2021.
//

import Foundation

enum Endpoints {
    case recipes(category: String)
    case categories
    // MARK: - Properties
    var url: URL? {
        return URL(string: baseURL + path)
    }
}

private extension Endpoints {
    var baseURL: String {
        return "https://themealdb.com"
    }
    var path: String {
        switch self {
        case .recipes(let category):
            return "/api/json/v1/1/filter.php?c=\(category)"
        case .categories:
            return "/api/json/v1/1/categories.php"
        }
    }
}
