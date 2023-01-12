//
//  LoginTests.swift
//  GoReceitasTests
//
//  Created by Igor Fernandes on 12/01/23.
//

import XCTest
@testable import GoReceitas

final class LoginTests: XCTestCase {
    
    var sut: LoginViewModel!
    var viewModel: LoginViewModelProtocol!
    var loginMock: LoginViewModelMock!
    
    override func setUp() {
        super.setUp()
        sut = LoginViewModel()
        loginMock = LoginViewModelMock()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        // given
        let email = "test@example.com"
        let password = "password"
        
        // when
        loginMock.login(email: email, password: password)
        
        // then
        XCTAssertEqual(loginMock.email, email)
        XCTAssertEqual(loginMock.password, password)
        XCTAssertTrue(loginMock.loginCalled)
        XCTAssertTrue(loginMock.isLoginSuccesful)
    }
    
    func testIfLoginWithGoogleIsPresentingViewController() {
        let viewController = UIViewController()
        
        loginMock.loginWithGoogle(presentingViewController: viewController)
        XCTAssertEqual(loginMock.viewController, viewController)
    }
    
    
    func testLoginFail() {
        // given
        let email = "abc"
        let password = "abc"
        
        // when
        loginMock.login(email: email, password: password)
        
        // then
        XCTAssertEqual(loginMock.email, email)
        XCTAssertEqual(loginMock.password, password)
        loginMock.showAlert(title: "", message: "")
        // should be false
        XCTAssertFalse(loginMock.isLoginSuccesful, "login succesful!")
    }
}

class LoginViewModelMock: LoginViewModelProtocol, LoginViewModelDelegate {
    var isLoginSuccesful = false
    var title = ""
    var message = ""
    
    func showAlert(title: String, message: String) {
        self.title = title
        self.message = message
        isLoginSuccesful = false
    }
    
    func signInUser() {
        isLoginSuccesful = true
    }
    
    var loginCalled = false
    var email = ""
    var password = ""
    var viewController: UIViewController?
    
    func login(email: String, password: String) {
        loginCalled = true
        isLoginSuccesful = true
        self.email = email
        self.password = password
    }
    
    func loginWithGoogle(presentingViewController: UIViewController) {
        self.viewController = presentingViewController
    }
}
