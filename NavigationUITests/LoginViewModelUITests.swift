//
//  NavigationUITests.swift
//  NavigationUITests
//
//  Created by Yoji on 20.11.2024.
//

import XCTest

final class NavigationUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = true
        XCUIApplication().launch()
    }

    
    @MainActor
    func testLoginInvalidUser() throws {

        let profileBtn = app.tabBars.buttons.element(boundBy: 1)
        profileBtn.tap()
        
        let loginTextField = app.textFields["LoginTextField"]
        loginTextField.tap()
        loginTextField.typeText("some")
        
        let loginButton = app.buttons["LoginButton"]
        loginButton.tap()
        
        XCTAssert(app.alerts.element.staticTexts["Пользователь не существует"].waitForExistence(timeout: 1))
    }

    @MainActor
    func testLoginInvalidPassword() throws {
        let profileBtn = app.tabBars.buttons.element(boundBy: 1)
        profileBtn.tap()
        
        let passwordTextField = app.secureTextFields["PasswordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("some text")
        
        let loginButton = app.buttons["LoginButton"]
        loginButton.tap()

        XCTAssert(app.alerts.element.staticTexts["Неверный пароль"].waitForExistence(timeout: 1))
    }
}
