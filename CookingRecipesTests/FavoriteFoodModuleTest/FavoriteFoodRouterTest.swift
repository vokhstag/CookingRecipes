//
//  FavoriteFoodRouterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 05.12.2021.
//

import XCTest

class FavoriteFoodRouterTest: XCTestCase {
    var assemblyBuilder: MockAssemblyBuilder!
    var router: FavoriteFoodRouter!
    var dataManager: MockDishesDataManager!

    override func setUpWithError() throws {
        assemblyBuilder = MockAssemblyBuilder()
        dataManager = MockDishesDataManager()
        router = FavoriteFoodRouter(tabBarController: nil,
                                    navigationController: UINavigationController(),
                                    assemblyBuilder: assemblyBuilder,
                                    dishesDataManager: dataManager)
    }

    override func tearDownWithError() throws {
        router = nil
        assemblyBuilder = nil
        dataManager = nil
    }
    func testThatInitialViewControllerMethodAddsControllerAtNavigationStack() {
        // act
        router.initialViewController()
        // aseert
        XCTAssertNotNil(router.navigationController.viewControllers.first,
                        "Method InitialViewController didn't add viewController at the navigation stack")
    }
    func testThatShowDetailControllerMethodAddsControllerAtNavigationStack() {
        // act
        router.showDetailController(dish: Dish())
        // aseert
        XCTAssertNotNil(router.navigationController.viewControllers.first,
                        "Method showDetailController didn't add viewController at the navigation stack")
    }
}
