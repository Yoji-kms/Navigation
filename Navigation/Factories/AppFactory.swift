//
//  AppFactory.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

final class AppFactory {
    private let loginInspector: LoginInspector
    
    init(loginInspector: LoginInspector) {
        self.loginInspector = loginInspector
    }
    
    func makeTab(ofType tabType: Module.TabType, rootViewController rootVC: UIViewController) -> UIViewController {
        switch tabType {
        case .profile:
            let viewController: UINavigationController = {
                let navController = UINavigationController(rootViewController: rootVC)
                navController.navigationBar.isHidden = true
                return navController
            }()
            return viewController
            
        case .feed:
            let viewController: UINavigationController = {
                let navController = UINavigationController(rootViewController: rootVC)
                navController.title = NSLocalizedString("Feed", comment: "Feed")
                return navController
            }()
            return viewController
        }
    }
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .profile(let user):
            let viewModel = ProfileViewModel(user: user)
            let viewController: UIViewController = ProfileViewController(viewModel: viewModel)
            return Module(moduleType: .profile(user), viewModel: viewModel, viewController: viewController)
        case .feed:
            let viewModel = FeedViewModel()
            let viewController: UIViewController = FeedViewController(viewModel: viewModel)
            return Module(moduleType: .feed, viewModel: viewModel, viewController: viewController)
        case .login:
            let viewModel = LoginViewModel(loginInspector: loginInspector)
            let viewController: UIViewController = LogInViewController(loginViewModel: viewModel)
            return Module(moduleType: .login, viewModel: viewModel, viewController: viewController)
        case .post(let post):
            let viewModel = PostViewModel(post: post)
            let viewController: UIViewController = PostViewController(viewModel: viewModel)
            return Module(moduleType: .post(post), viewModel: viewModel, viewController: viewController)
        case .info:
            let viewModel = InfoViewModel()
            let viewController: UIViewController = InfoViewController(viewModel: viewModel)
            return Module(moduleType: .info, viewModel: viewModel, viewController: viewController)
        }
    }
}
