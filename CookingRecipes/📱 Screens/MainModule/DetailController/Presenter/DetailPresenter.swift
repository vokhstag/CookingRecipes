//
//  DetailPresenter.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import Foundation

protocol DetailPresenterType {
    var categories: [Dish] { get }
}

class DetailPresenter: DetailPresenterType {
    var categories: [Dish] = []

}
