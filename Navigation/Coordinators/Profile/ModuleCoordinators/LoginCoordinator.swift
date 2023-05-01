//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

final class LoginCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = self.factory.makeModule(ofType: self.moduleType)
        let viewController = module.viewController
        (module.viewModel as? LoginViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushProfileViewController(forUser user: UserModel) {
        let profileCoordinator = ProfileCoordinator(moduleType: .profile(user), factory: self.factory)
        self.addChildCoordinator(profileCoordinator)
        
        let viewControllerToPush = profileCoordinator.start()
        self.module?.viewController.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
    func pushRegisterViewController(delegate: RegisterDelegate?) {
        let registerModule = self.factory.makeModule(ofType: .register)
        let viewControllerToPush = registerModule.viewController
        (registerModule.viewModel as? RegisterViewModel)?.delegate = delegate
        self.module?.viewController.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
