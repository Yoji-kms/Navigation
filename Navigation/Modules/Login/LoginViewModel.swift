//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    
    let defaultLogin = Configuration.login
    let defaultPassword = "pswrd"
    
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
            guard let context = self.coordinator?.module?.viewController else { return }
            let currentUserService = Configuration.userService
            guard let user = currentUserService.getUser(login: login) else {
                AlertUtils.showUserMessage(NSLocalizedString("User does not exist", comment: "User does not exist"), context: context)
                return
            }
            if self.loginInspector.check(login: login, password: password) {
                self.coordinator?.pushProfileViewController(forUser: user)
            } else {
                AlertUtils.showUserMessage(NSLocalizedString("Incorrect password", comment: "Incorrect password"), context: context)
            }
        }
    }
}
