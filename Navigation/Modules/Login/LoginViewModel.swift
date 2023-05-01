//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

final class LoginViewModel: LoginViewModelProtocol {
    
    let defaultLogin = "test@mail.ru"
    let defaultPassword = "qqqqqq"
    
    enum LoginError: Error {
        case noContext
    }
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case loginBtnDidTap(String, String)
        case registerBtnDidTap
    }
    
    var coordinator: LoginCoordinator?
    
    private(set) var state: State = .initial
    
    private(set) var checkerService: CheckerServiceProtocol
    
    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }
    
    func updateState(viewInput: ViewInput) {
        guard let context = try? self.getContext() else {
            preconditionFailure("🟡 No context")
        }
        
        switch viewInput {
        case let .loginBtnDidTap(login, password):
            self.checkLogin(login, password: password, context: context)
        case .registerBtnDidTap:
            self.coordinator?.pushRegisterViewController(delegate: self)
        }
    }
    
    private func getContext() throws -> UIViewController {
        if let context = self.coordinator?.module?.viewController {
            return context
        } else {
            throw LoginError.noContext
        }
    }
    
    private func checkLogin(_ login: String, password: String, context: UIViewController) {
        self.checkerService.checkCredentials(login: login, password: password) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let user):
                strongSelf.coordinator?.pushProfileViewController(forUser: user)
            case .failure(.invalidEmail):
                AlertUtils.showUserMessage(NSLocalizedString("Invalid email", comment: "Invalid email"), context: context)
            case .failure(.userNotFound):
                AlertUtils.showUserMessage(NSLocalizedString("User does not exist", comment: "User does not exist"), context: context)
            case .failure(.wrongPassword):
                AlertUtils.showUserMessage(NSLocalizedString("Incorrect password", comment: "Incorrect password"), context: context)
            case .failure(let error):
                print("🔴\(error)")
            }
        }
    }
}

extension LoginViewModel: RegisterDelegate {
    func register(login: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        self.checkerService.signUp(login: login, password: password) { result in
            switch result {
            case .success(let user):
                self.coordinator?.pushProfileViewController(forUser: user)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
