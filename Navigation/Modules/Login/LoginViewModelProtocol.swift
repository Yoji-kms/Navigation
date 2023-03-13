//
//  LoginViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

protocol LoginViewModelProtocol: ViewModelProtocol {
    var defaultLogin: String { get }
    var operation: UnlockPasswordOperation? { get }
    var password: String { get }

    func updateState(viewInput: LoginViewModel.ViewInput)
}
