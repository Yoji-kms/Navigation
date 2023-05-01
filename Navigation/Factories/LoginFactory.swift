//
//  LoginFactory.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

protocol LoginFactory {
    func makeCheckerService() -> CheckerServiceProtocol
}
