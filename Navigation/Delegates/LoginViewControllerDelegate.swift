//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}
