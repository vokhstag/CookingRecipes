//
//  MainContainerPresenterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 24.11.2021.
//

import XCTest
@testable import CookingRecipes

// MARK: - Mocks
class MockContaiterView: MainContainerViewProtocol {
    var succesCalled = false
    var failureCalled = false
    func succes() {
        succesCalled = true
    }
    func failure(errorDescription: String) {
        failureCalled = true
    }
}
class MockContentPresenter: UpdateContentProtocol {
    var updatedWithName = false
    var updatedWhenSearchText = false
    func update(with category: String) {
        updatedWithName = true
    }
    func update(withSearchText text: String) {
        updatedWhenSearchText = true
    }
}
class MockCategoriesNetwork: CategoriesNetworkServiceProtocol {
    func getCategories(url: URL, completion: @escaping (CategoriesResponse) -> Void) {
        let category = Category(id: "", name: "", imageURL: "", description: "")
        completion(.success([category]))
    }
}
class MockCategoriesNetworkWithErrorComplition: CategoriesNetworkServiceProtocol {
    func getCategories(url: URL, completion: @escaping (CategoriesResponse) -> Void) {
        completion(.failure(.network))
    }
}
class MockUserDataManager: UserDataManagerProtocol {
    func getActiveUser() -> User? {
        nil
    }
    func createUser(name: String, login: String, password: String) -> Bool {
        true
    }
}

class MainContainerPresenterTest: XCTestCase {
    var view: MockContaiterView!
    var contentPresenter: MockContentPresenter!
    var network: CategoriesNetworkServiceProtocol!
    var presenter: MainContainerPresenter!
    var dataManager: MockUserDataManager!

    override func setUpWithError() throws {
        view = MockContaiterView()
        contentPresenter = MockContentPresenter()
        network = MockCategoriesNetwork()
        dataManager = MockUserDataManager()
        presenter = MainContainerPresenter(view: view, network: network, userDataManager: dataManager)
        presenter.delegate = contentPresenter
    }

    override func tearDownWithError() throws {
        view = nil
        contentPresenter = nil
        network = nil
        dataManager = nil
        presenter = nil
    }
    func testThatModuleIsNotNil() {
        // assert
        XCTAssertNotNil(view, "view is nil")
        XCTAssertNotNil(network, "network is nil")
        XCTAssertNotNil(contentPresenter, "contentPresenter is nil")
        XCTAssertNotNil(presenter, "presenter is nil")
    }
    func testThatViewUpdatesAfterGettingCategories() {
        // act
        presenter.getCategories()
        // assert
        XCTAssertTrue(view.succesCalled, "view.succes didn't called after getting categories")
    }
    func testThatViewFailureCalledWhenCategoriesAreNotReceived() {
        // arranged
        network = MockCategoriesNetworkWithErrorComplition()
        presenter = MainContainerPresenter(view: view, network: network, userDataManager: dataManager)
        // act
        presenter.getCategories()
        // assert
        XCTAssertTrue(view.failureCalled, "View failure not called when categories are not received")
    }
    func testThatContentPresenterUpdatesAfterGettingCategories() {
        // act
        presenter.getCategories()
        // assert
        XCTAssertTrue(contentPresenter.updatedWithName,
                      "contentPresenter not updates after getting category")
    }
    func testThatContentPresenterUpdatesAfterSelectingCategory() {
        // arranged
        let categoryName = "Meat"
        // act
        presenter.selectedCategoryName = categoryName
        // assert
        XCTAssertTrue(contentPresenter.updatedWithName,
                      "contentPresenter not updates after selecting category")
    }
}
