//
//  TabBarController.swift
//  Navigation
//
//  Created by Yoji on 28.06.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var profileNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: ProfileViewController())
        navController.title = "Profile"
        navController.tabBarItem.title = "Profile"
        navController.tabBarItem.image = UIImage(systemName: "person")
        return navController
    }()
    
    private lazy var feedNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: FeedViewController())
        navController.title = "Feed"
        navController.tabBarItem.title = "Feed"
        navController.tabBarItem.image = UIImage(systemName: "lanyardcard")
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .gray
        self.viewControllers = [profileNavController, feedNavController]
    }
}
