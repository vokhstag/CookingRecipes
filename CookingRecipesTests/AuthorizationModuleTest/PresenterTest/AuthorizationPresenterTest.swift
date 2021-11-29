//
//  AuthorizationPresenterTest.swift
//  CookingRecipesTests
//
//  Created by Yunus Abubakarov on 29.11.2021.
//

import XCTest
@testable import CookingRecipes

// MARK: - MOCKS
class MockAuthorizationView: AuthorizationViewProtocol {
    var succesCalled = false
    var failureCalled = false
    func succes() {
        succesCalled = true
    }
    
    func failure(errorDescription: String) {
        failureCalled = true
    }
}

class AuthorizationPresenterTest: XCTestCase {
    var view: MockAuthorizationView!
    var dataMannager: MockUserDataManager!
    var presenter: AuthorizationPresenter!
    // MARK: Setup
    override func setUpWithError() throws {
        view = MockAuthorizationView()
        dataMannager = MockUserDataManager()
        presenter = AuthorizationPresenter(view: view,
                                           dataManager: dataMannager)
    }
    override func tearDownWithError() throws {
        view = nil
        dataMannager = nil
        presenter = nil
    }
    // MARK: Tests
    func testThatCreatingNewUserCallsSuccesInView() {
        // act
        presenter.createNewUser(name: "", login: "", password: "")
        // assert
        XCTAssertTrue(view.succesCalled, "view.succes() not called")
    }

}
