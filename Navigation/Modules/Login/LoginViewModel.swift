//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

final class LoginViewModel: LoginViewModelProtocol {
    
    let defaultLogin = Configuration.login
    let defaultPassword = "pswrd"
    
    enum LoginError: Error {
        case noContext
        case userNotFound
        case wrongPassword
    }
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case loginBtnDidTap(String, String)
    }
    
    weak var coordinator: LoginCoordinator?
    
    private(set) var state: State = .initial
    
    private(set) var loginInspector: LoginInspector
    
    init(loginInspector: LoginInspector) {
        self.loginInspector = loginInspector
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case let .loginBtnDidTap(login, password):
            guard let context = try? self.getContext() else {
                preconditionFailure("🟡 No context")
            }
            
            do {
                try self.getUser(login) { result in
                    switch result {
                    case .success(let user):
                        try self.checkLogin(login, password: password)
                        self.coordinator?.pushProfileViewController(forUser: user)
                    case .failure(_):
                        AlertUtils.showUserMessage(NSLocalizedString("User does not exist", comment: "User does not exist"), context: context)
                    }
                    
                }
            }
            catch LoginError.wrongPassword {
                AlertUtils.showUserMessage(NSLocalizedString("Incorrect password", comment: "Incorrect password"), context: context)
            }
            catch {
                print("♦️ Unknown error")
            }
        }
    }
    
    private func getContext() throws -> UIViewController {
        if let context = self.coordinator?.module?.viewController {
            return context
        } else {
            throw LoginError.noContext
        }
    }
    
    private func getUser(_ login: String, completion: (Result<User, LoginError>) throws -> Void) throws {
        let currentUserService = Configuration.userService
             
        if let user = currentUserService.getUser(login: login) {
            try completion(.success(user))
        } else {
            try completion(.failure(.userNotFound))
        }
    }
    
    private func checkLogin(_ login: String, password: String) throws {
        if self.loginInspector.check(login: login, password: password) {
            return
        } else {
            throw LoginError.wrongPassword
        }
    }
}
