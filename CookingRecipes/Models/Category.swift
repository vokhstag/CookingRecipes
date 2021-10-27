//
//  Category.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

struct Category: Decodable {
    let idCategory: Int
    let strCategory: String
    let strCategoryThumb: String?
    let strCategoryDescription: String?
}
