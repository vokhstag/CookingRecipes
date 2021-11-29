//
//  MainRouterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 29.11.2021.
//

import XCTest

// MARK: - Mocks
class MockAssemblyBuilder: AssemblyBuilderProtocol {
    func createMainController(router: MainRouterProtocol,
                              userDataManager: UserDataManagerProtocol) -> UIViewController {
        return UIViewController()
    }
    func createFavoriteFoodController(router: FavoriteFoodRouterProtocol,
                                      dataManager: DishesDataManagerProtocol) -> UIViewController {
        return UIViewController()
    }
    func createDetailController(dish: Dish,
                                dataManager: DishesDataManagerProtocol,
                                router: BaseRouter) -> UIViewController {
        return UIViewController()
    }
    func createAuthorizationController(dataManager: UserDataManagerProtocol) -> UIViewController {
        return UIViewController()
    }
    func createIngredientController(url: URL?, name: String, measure: String?) -> UIViewController {
        return UIViewController()
    }
}

class MainRouterTest: XCTestCase {
    var assemblyBuilder: MockAssemblyBuilder!
    var router: MainRouter!
    var useDataManager: MockUserDataManager!

    override func setUpWithError() throws {
        assemblyBuilder = MockAssemblyBuilder()
        useDataManager = MockUserDataManager()
        router = MainRouter(tabBarController: UITabBarController(),
                            navigationController: UINavigationController(),
                            assemblyBuilder: assemblyBuilder,
                            userDataManager: useDataManager,
                            dishesDataManager: MockDishesDataManager())
    }

    override func tearDownWithError() throws {
        assemblyBuilder = nil
        router = nil
    }
    // MARK: Tests
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
    func testThatShowIngredientControllerMethodPresentsControllerAtNavigationStack() {
        // act
        router.showIngredientController(url: nil, name: "", measure: nil)
        // aseert
        XCTAssertNotNil(router.navigationController.presentationController,
                        "Method showIngredientController didn't present viewController at the navigation stack")
    }
    func testThatShowAuthorizationControllerIfNeedChecksIfThereIsAnActiveUser() {
        // act
        router.showAuthorizationControllerIfNeed()
        // assetr
        XCTAssertTrue(useDataManager.isGetActiveUserCalled,
                      "showAuthorizationControllerIfNeed method not check if there is an active user ")
    }
}
