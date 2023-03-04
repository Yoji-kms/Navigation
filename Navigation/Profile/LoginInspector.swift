//
//  LoginInspector.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

class LoginInspector {}

extension LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
