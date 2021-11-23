//
//  UserDataManager.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 22.11.2021.
//

import Foundation
import CoreData

protocol UserDataManagerProtocol {
    func getActiveUser() -> User?
    func createUser(name: String, login: String, password: String) -> Bool
}

class UserDataManager {
    // MARK: - Private properties
    private let context = AppDelegate.viewContext
    private let fetchResult: NSFetchRequest<User> = User.fetchRequest()
}
// MARK: - UserDataManagerProtocol
extension UserDataManager: UserDataManagerProtocol {
    func getActiveUser() -> User? {
        let predicate = NSPredicate(format: "isActive = %@", argumentArray: [true])
        fetchResult.predicate = predicate
        let users = try? context.fetch(fetchResult)
        return users?.first
    }
    func createUser(name: String, login: String, password: String) -> Bool {
        let user = User(context: context)
        user.name = name
        user.login = login
        user.password = password
        user.isActive = true
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
