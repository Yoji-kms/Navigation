//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Yoji on 04.03.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}
