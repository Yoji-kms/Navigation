//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

final class PostCoordinator: ModuleCoordinatable {
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
        (module.viewModel as? PostViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func presentInfoViewController() {
        let infoCoordinator = InfoCoordinator(moduleType: .info, factory: self.factory)
        self.addChildCoordinator(infoCoordinator)
        guard let viewControllerToPresent = infoCoordinator.start() as? InfoViewController else {
            return
        }
        let delegate = self.module?.viewController as? RemoveChildCoordinatorDelegate
        viewControllerToPresent.delegate = delegate
        
        viewControllerToPresent.modalPresentationStyle = .popover
        viewControllerToPresent.modalTransitionStyle = .crossDissolve
        
        module?.viewController.navigationController?.present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func didReturnFromInfoViewController(coordinator: Coordinatable) {
        self.removeChildCoordinator(coordinator)
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
