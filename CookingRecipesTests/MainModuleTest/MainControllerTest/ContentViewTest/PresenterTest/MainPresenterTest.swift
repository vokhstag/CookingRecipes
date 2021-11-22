//
//  MainPresenterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 22.11.2021.
//

import XCTest
@testable import CookingRecipes

// MARK: - Mocks
class MockMainVC: MainViewProtocol {
    var loadCalled = false
    var succesCalled = false
    var errorDescription = ""
    func load() {
        loadCalled = true
    }
    func succes() {
        succesCalled = true
    }
    func failure(errorDescription: String) {
        self.errorDescription = errorDescription
    }
}

class MockRecipesNetwork: RecipesNetworkServiceProtocol {
    func getDishes(url: URL, completion: @escaping (RecipesResponse) -> Void) {
        completion(.success([]))
    }
    func searchDishes(url: URL, completion: @escaping (RecipesResponse) -> Void) {
        completion(.success([]))
    }
}

class MockMainRouter: MainRouterProtocol {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController = UINavigationController()
    var assemblyBuilder: AssemblyBuilderProtocol?
    var showDetailControllerCalled = false
    func initialViewController() {
    }
    func showDetailController(dish: Dish) {
        showDetailControllerCalled = true
    }
}

class MainPresenterTest: XCTestCase {
    var view: MockMainVC!
    var network: MockRecipesNetwork!
    var router: MockMainRouter!
    var presenter: MainPresenter!
    override func setUpWithError() throws {
        view = MockMainVC()
        network = MockRecipesNetwork()
        router = MockMainRouter()
        presenter = MainPresenter(view: view, networkService: network, router: router)
    }

    override func tearDownWithError() throws {
        view = nil
        network = nil
        router = nil
        presenter = nil
    }
    func teestThatModuleIsNotNil() {
        //assert
        XCTAssertNotNil(view, "view is nil")
        XCTAssertNotNil(network, "network is nil")
        XCTAssertNotNil(router, "router is nil")
        XCTAssertNotNil(presenter, "presenter is nil")
    }
    func testThatMethodGetListOfDishesCallsLoadingInView() throws {
        // arranged
        let url = URL(string: "https://google.com")
        // act
        presenter.getListOfDishes(url: url)
        // assert
        XCTAssertTrue(view.loadCalled, "view.load() was not called")
    }
    func testThatMethodSearchDishesCallsLoadingInView() throws {
        // arranged
        let url = URL(string: "https://google.com")
        // act
        presenter.searchDishes(url: url)
        // assert
        XCTAssertTrue(view.loadCalled, "view.load() was not called")
    }
    func testThatMethodGetListOfDishesCallsSuccesInView() {
        // arranged
        let url = URL(string: "https://google.com")
        // act
        presenter.getListOfDishes(url: url)
        // assert
        XCTAssertTrue(view.succesCalled, "view.succes() was not called")
    }
    func testThatMethodSearchDishesCallsSuccesInView() {
        // arranged
        let url = URL(string: "https://google.com")
        // act
        presenter.searchDishes(url: url)
        // assert
        XCTAssertTrue(view.succesCalled, "view.succes() was not called")
    }
    func testThatMethodGoToDetailRecipeCallsRouter() {
        // arranger
        let dish = Dish()
        // act
        presenter.goToDetailRecipe(dish: dish)
        // assert
        XCTAssertTrue(router.showDetailControllerCalled, "router.showDetailController() war not called")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
