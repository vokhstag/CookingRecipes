//
//  DishesDataManager.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 23.11.2021.
//

import Foundation
import CoreData

protocol DishesDataManagerProtocol {
    func saveDish(dish: Dish)
    func getDishes() -> [FavoriteDish]
    func dishBy(id: String) -> FavoriteDish?
    func deleteDishBy(id: String)
}

class DishesDataManager {
    // MARK: - Private properties
    private let context = AppDelegate.viewContext
    private let userFetchResult: NSFetchRequest<User> = User.fetchRequest()
    private let dishFetchResult: NSFetchRequest<FavoriteDish> = FavoriteDish.fetchRequest()
    private var user: User?
    // MARK: - Constructor
    init() {
        let predicate = NSPredicate(format: "isActive = %@", argumentArray: [true])
        userFetchResult.predicate = predicate
        let users = try? context.fetch(userFetchResult)
        self.user = users?.first
    }
}
// MARK: - SetDishesDataManagerProtocol
extension DishesDataManager: DishesDataManagerProtocol {
    func saveDish(dish: Dish) {
        let favoriteDish = FavoriteDish(context: context)
        favoriteDish.id = dish.id
        favoriteDish.name = dish.name
        favoriteDish.instructions = dish.instructions
        favoriteDish.youtube = dish.youtube
        favoriteDish.category = dish.category
        favoriteDish.country = dish.country
        favoriteDish.imageUrl = dish.imageUrl
        favoriteDish.ingredient1 = dish.ingredient1
        favoriteDish.ingredient2 = dish.ingredient2
        favoriteDish.ingredient3 = dish.ingredient3
        favoriteDish.ingredient4 = dish.ingredient4
        favoriteDish.ingredient5 = dish.ingredient5
        favoriteDish.ingredient6 = dish.ingredient6
        favoriteDish.ingredient7 = dish.ingredient7
        favoriteDish.ingredient8 = dish.ingredient8
        favoriteDish.ingredient9 = dish.ingredient9
        favoriteDish.ingredient10 = dish.ingredient10
        favoriteDish.measure1 = dish.measure1
        favoriteDish.measure2 = dish.measure2
        favoriteDish.measure3 = dish.measure3
        favoriteDish.measure4 = dish.measure4
        favoriteDish.measure5 = dish.measure5
        favoriteDish.measure6 = dish.measure6
        favoriteDish.measure7 = dish.measure7
        favoriteDish.measure8 = dish.measure8
        favoriteDish.measure9 = dish.measure9
        favoriteDish.measure10 = dish.measure10
        favoriteDish.user = user
        try? context.save()
    }
    func getDishes() -> [FavoriteDish] {
        guard let user = user else { return [] }
        let predicate = NSPredicate(format: "user = %@", argumentArray: [user])
        dishFetchResult.predicate = predicate
        do {
            let dishes = try context.fetch(dishFetchResult)
            return dishes
        } catch {
            return []
        }
    }
    func dishBy(id: String) -> FavoriteDish? {
        guard let user = user else { return nil }
        let predicate = NSPredicate(format: "user = %@ && id = %@", argumentArray: [user, id])
        dishFetchResult.predicate = predicate
        do {
            let dishes = try context.fetch(dishFetchResult)
            return dishes.first
        } catch {
            return nil
        }
    }
    func deleteDishBy(id: String) {
        guard let dish = dishBy(id: id) else { return }
        context.delete(dish)
    }
}
