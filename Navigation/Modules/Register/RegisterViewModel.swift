//
//  RegisterViewModel.swift
//  Navigation
//
//  Created by Yoji on 28.04.2023.
//

import UIKit

final class RegisterViewModel: RegisterViewModelProtocol {
    enum LoginError: Error {
        case noContext
    }
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case registerBtnDidTap(String, String, (Result<Void, FirebaseError>) -> Void)
    }
    
    weak var delegate: RegisterDelegate?
    
    private(set) var state: State = .initial
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .registerBtnDidTap(let login, let password, let completion):
            delegate?.register(login: login, password: password, completion: completion)
        }
    }
}
