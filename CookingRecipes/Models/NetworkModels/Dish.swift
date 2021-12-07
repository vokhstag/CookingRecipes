//
//  Dish.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import Foundation

struct Dish: Decodable {
    var id: String
    var name: String?
    var drinkAlternate: String?
    var category: String?
    var country: String?
    var instructions: String?
    var imageUrl: String?
    var tags: String?
    var youtube: String?
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var measure1: String?
    var measure2: String?
    var measure3: String?
    var measure4: String?
    var measure5: String?
    var measure6: String?
    var measure7: String?
    var measure8: String?
    var measure9: String?
    var measure10: String?
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case country = "strArea"
        case instructions = "strInstructions"
        case imageUrl = "strMealThumb"
        case tags = "strTags"
        case youtube = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
    }
    // MARK: - helpers
    func allMeasures() -> [String?] {
        let measures = [
            measure1,
            measure2,
            measure3,
            measure4,
            measure5,
            measure6,
            measure7,
            measure8,
            measure9,
            measure10
        ]
        return measures
    }
    func allIngredients() -> [String] {
        let ingredients = [
            ingredient1,
            ingredient2,
            ingredient3,
            ingredient4,
            ingredient5,
            ingredient6,
            ingredient7,
            ingredient8,
            ingredient9,
            ingredient10
        ].compactMap { return $0 }
        .filter {
            $0 != "" && $0 != " "
        }
        return ingredients
    }
    init() {
        self.id = ""
    }
    func getVideoURL() -> URL? {
        guard let videoUrlStr = youtube else { return nil }
        let videoCode = videoUrlStr.split(separator: "=").last
        guard let code = videoCode else { return nil}
        return URL(string: "https://www.youtube.com/embed/\(code)")
    }
}

struct Meals: Decodable {
    var meals: [Dish]
}
