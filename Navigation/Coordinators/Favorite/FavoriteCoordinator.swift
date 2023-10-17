//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import UIKit

final class FavoriteCoordinator: ModuleCoordinatable {
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
        (module.viewModel as? FavoriteViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
}
