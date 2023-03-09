//
//  LoginInspector.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

struct LoginInspector {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
