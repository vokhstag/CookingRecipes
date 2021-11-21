//
//  DetailPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import Foundation

protocol DetailPresenterType {
    var dish: Dish { get }
}

class DetailPresenter: DetailPresenterType {
    var dish: Dish

    init(dish: Dish) {
        self.dish = dish
    }
}
