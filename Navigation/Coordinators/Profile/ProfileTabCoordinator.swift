//
//  ProfileTabCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

final class ProfileTabCoordinator: Coordinatable {
    let tabType: Module.TabType
    
    private let factory: AppFactory
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    init(tabType: Module.TabType, factory: AppFactory) {
        self.tabType = tabType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let loginCoordinator = LoginCoordinator(moduleType: .login, factory: factory)
        
        self.addChildCoordinator(loginCoordinator)
        
        let viewController = self.factory.makeTab(ofType: self.tabType, rootViewController: loginCoordinator.start())
        viewController.tabBarItem = tabType.tabBarItem

        return viewController
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
