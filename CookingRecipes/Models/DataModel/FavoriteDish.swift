//
//  FavoriteDish.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 22.11.2021.
//

import CoreData

class FavoriteFood: NSManagedObject {
    func getDish() -> Dish {
        var dish = Dish()
        dish.id = id ?? ""
        dish.name = name
        dish.category = category
        dish.country = country
        dish.instructions = instructions
        dish.imageUrl = imageUrl
        dish.youtube = youtube
        dish.ingredient1 = ingredient1
        dish.ingredient2 = ingredient2
        dish.ingredient3 = ingredient3
        dish.ingredient4 = ingredient4
        dish.ingredient5 = ingredient5
        dish.ingredient6 = ingredient6
        dish.ingredient7 = ingredient7
        dish.ingredient8 = ingredient8
        dish.ingredient9 = ingredient9
        dish.ingredient10 = ingredient10
        dish.measure1 = measure1
        dish.measure2 = measure2
        dish.measure3 = measure3
        dish.measure4 = measure4
        dish.measure5 = measure5
        dish.measure6 = measure6
        dish.measure7 = measure7
        dish.measure8 = measure8
        dish.measure9 = measure9
        dish.measure10 = measure10
        return dish
    }
}
