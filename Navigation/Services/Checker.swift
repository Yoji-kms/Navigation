//
//  Checker.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

final class Checker {
// MARK: Variables
    private let login = Configuration.login
    var password = "pswrd"
    
// MARK: Singleton init
    private init() {}
    static let shared = Checker()
   
// MARK: Methods
    func check(login: String, password: String) -> Bool {
        return ((login == self.login) && (password == self.password))
    }
}

