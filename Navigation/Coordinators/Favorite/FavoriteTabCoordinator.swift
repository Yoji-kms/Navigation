//
//  FavoriteTabCoordinator.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import UIKit

final class FavoriteTabCoordinator: Coordinatable {
    let tabType: Module.TabType
    
    private let factory: AppFactory
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    init(tabType: Module.TabType, factory: AppFactory) {
        self.tabType = tabType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let favoriteCoordinator = FavoriteCoordinator(moduleType: .favorite, factory: factory)
        
        self.addChildCoordinator(favoriteCoordinator)
        
        let viewController = self.factory.makeTab(
            ofType: self.tabType,
            rootViewController: favoriteCoordinator.start()
        )
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
