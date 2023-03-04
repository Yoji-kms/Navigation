//
//  TabBarController.swift
//  Navigation
//
//  Created by Yoji on 28.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    private let loginInspector: LoginInspector
    
    init(loginInspector: LoginInspector){
        self.loginInspector = loginInspector
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var profileNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: LogInViewController(loginInspector: loginInspector))
        navController.navigationBar.isHidden = true
        navController.tabBarItem.title = NSLocalizedString("Profile", comment: "Profile")
        navController.tabBarItem.image = UIImage(systemName: "person.fill")
        return navController
    }()
    
    private lazy var feedNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: FeedViewController())
        navController.title = NSLocalizedString("Feed", comment: "Feed")
        navController.tabBarItem.title = NSLocalizedString("Feed", comment: "Feed")
        navController.tabBarItem.image = UIImage(systemName: "lanyardcard.fill")
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.tintColor = .init(named: "VkColor")
        self.tabBar.barTintColor = .systemGray6
        self.tabBar.backgroundColor = .systemGray6
        self.viewControllers = [feedNavController, profileNavController]
    }
}
