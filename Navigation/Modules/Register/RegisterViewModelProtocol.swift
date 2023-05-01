//
//  RegisterViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 29.04.2023.
//

import Foundation

protocol RegisterViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: RegisterViewModel.ViewInput)
}
