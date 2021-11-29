//
//  Category.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

struct Category: Decodable {
    let id: String
    let name: String
    let imageURL: String?
    let description: String?
    private enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case imageURL = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct Categories: Decodable {
    let categories: [Category]
}
