//
//  LoginViewModelTests.swift
//  NavigationTests
//
//  Created by Yoji on 19.11.2024.
//

import Testing
@testable import Navigation

struct LoginViewModelTests {
    let loginViewModel: LoginViewModel
    
    init() {
        let loginInspector = LoginInspector()
        self.loginViewModel = LoginViewModel(loginInspector: loginInspector)
    }
    
    @Test func loginBtnDidTapTest() async throws {
        #expect(throws: Never.self) {
            try loginViewModel.updateState(viewInput: .loginBtnDidTap(Configuration.login, "pswrd"))
        }
    }
}

