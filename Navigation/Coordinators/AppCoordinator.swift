//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    private(set) var childCoordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let profileTabCoordinator = ProfileTabCoordinator(tabType: .profile, factory: factory)
        let feedTabCoordinator = FeedTabCoordinator(tabType: .feed, factory: factory)
        
        let appTabBarController = TabBarController(viewControllers: [
            feedTabCoordinator.start(),
            profileTabCoordinator.start()
        ])
        
        addChildCoordinator(feedTabCoordinator)
        addChildCoordinator(profileTabCoordinator)
        
        return appTabBarController
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 === coordinator }
    }
}
