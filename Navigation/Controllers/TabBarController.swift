//
//  TabBarController.swift
//  Navigation
//
//  Created by Yoji on 28.06.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var profileNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: LogInViewController())
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
