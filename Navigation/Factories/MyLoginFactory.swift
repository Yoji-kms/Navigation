//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

class MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
