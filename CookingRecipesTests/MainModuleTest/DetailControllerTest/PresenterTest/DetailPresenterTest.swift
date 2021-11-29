//
//  DetailPresenterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 29.11.2021.
//

import XCTest
@testable import CookingRecipes

// MARK: - Mocks
class MockDetailView: DetailViewProtocol {
    var dishRemoved = false
    var dishAdded = false
    var error = false
    func dishRemovedFromFavorite() {
        dishRemoved = true
    }
    func dishAddedToFavorite() {
        dishAdded = true
    }
    func failure(errorDescription: String) {
        error = true
    }
}

class MockRouter: BaseRouter {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController = UINavigationController()
    var assemblyBuilder: AssemblyBuilderProtocol?
}

class MockDishesDataManager: DishesDataManagerProtocol {
    var dishSaved = false
    var getDishMethodCalled = false
    var getDishByMethodCalled = false
    var dishDeleted = false
    func saveDish(dish: Dish) -> Bool {
        dishSaved = true
        return true
    }
    func getDishes() -> [FavoriteFood] {
        getDishMethodCalled = true
        return []
    }
    func dishBy(id: String) -> FavoriteFood? {
        getDishByMethodCalled = true
        return nil
    }
    func deleteDishBy(id: String) -> Bool {
        dishDeleted = true
        return true
    }
}

class DetailPresenterTest: XCTestCase {
    var view: MockDetailView!
    var dataManager: MockDishesDataManager!
    var router: MockRouter!
    var presenter: DetailPresenter!

    override func setUpWithError() throws {
        view = MockDetailView()
        dataManager = MockDishesDataManager()
        router = MockRouter()
        presenter = DetailPresenter(view: view,
                                    router: router,
                                    dish: Dish(),
                                    dishesDataManager: dataManager)
    }

    override func tearDownWithError() throws {
        view = nil
        dataManager = nil
        router = nil
        presenter = nil
    }

    func testThatSaveDishMethodCallDataManagerSaveDish() {
        // act
        presenter.saveDish()
        // assert
        XCTAssertTrue(dataManager.dishSaved, "DishesDataManager.saveDish() not called")
    }
    func testThatRemoveDishMethodCallDataManagerDeleteDish() {
        // act
        presenter.removeDishFromFavorite()
        // assert
        XCTAssertTrue(dataManager.dishDeleted, "DishesDataManager.deleteDishBy method not called")
    }
    func testThatIsFavoriiteFoodMethodCallDishByMethodInDataManager() {
        // act
        _ = presenter.isFavoriteDish()
        // assert
        XCTAssertTrue(dataManager.getDishByMethodCalled, "DishesDataManager.dishBy() not called")
    }
    func testThatRemoveDishMethodCallDishRemovedFromFavoriteInView() {
        // act
        presenter.removeDishFromFavorite()
        // assert
        XCTAssertTrue(view.dishRemoved, "view.dishRemovedFromFavorite() method not called")
    }
    func testThatSaveDishCalledDishAddedToFavoriteInView() {
        // act
        presenter.saveDish()
        // assert
        XCTAssertTrue(view.dishAdded, "view.dishAddedToFavorite method not called")
    }
}
