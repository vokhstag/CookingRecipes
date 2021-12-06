//
//  FavoriteFoodPresenterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 05.12.2021.
//

import XCTest

class MockFavoriteFoodRouter: FavoriteFoodRouterProtocol {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController = UINavigationController()
    var assemblyBuilder: AssemblyBuilderProtocol?
    var showDetailControllerCalled = false
    func initialViewController() {
    }
    func showDetailController(dish: Dish) {
        showDetailControllerCalled = true
    }
    func showIngredientController(url: URL?, name: String, measure: String?) {
    }
}

class FavoriteFoodPresenterTest: XCTestCase {
    var router: MockFavoriteFoodRouter!
    var dataManager: MockDishesDataManager!
    var presenter: FavoriteFoodPresenter!
    override func setUpWithError() throws {
        router = MockFavoriteFoodRouter()
        dataManager = MockDishesDataManager()
        presenter = FavoriteFoodPresenter(router: router,
                                          dishesDataManager: dataManager)
    }

    override func tearDownWithError() throws {
        router = nil
        dataManager = nil
        presenter = nil
    }
    func testThatMethodGoToDetailRecipeCallRouterShowDetailController() {
        // arranged
        let dish = Dish()
        // act
        presenter.goToDetailRecipe(dish: dish)
        // assert
        XCTAssertTrue(router.showDetailControllerCalled, "method showDetailController() was not called")
    }
}
