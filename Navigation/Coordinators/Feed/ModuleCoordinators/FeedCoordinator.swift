//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

final class FeedCoordinator: ModuleCoordinatable {
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
        (module.viewModel as? FeedViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushPostViewController(post: Post?) {
        let postCoordinator = PostCoordinator(moduleType: .post(post), factory: self.factory)
        self.addChildCoordinator(postCoordinator)
        guard let viewControllerToPush = postCoordinator.start() as? PostViewController else {
            return
        }
        let delegate = self.module?.viewController as? RemoveChildCoordinatorDelegate
        viewControllerToPush.delegate = delegate
        
        module?.viewController.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
    func didReturnFromPostViewController(coordinator: Coordinatable) {
        self.removeChildCoordinator(coordinator)
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
