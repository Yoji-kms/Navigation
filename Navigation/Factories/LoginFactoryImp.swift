//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

class LoginFactoryImp: LoginFactory {
    func makeCheckerService() -> CheckerServiceProtocol {
        return CheckerService()
    }
}
