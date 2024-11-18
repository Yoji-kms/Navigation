//
//  TabBarController.swift
//  Navigation
//
//  Created by Yoji on 28.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {    
    init(viewControllers: [UIViewController]){
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.tintColor = .init(resource: .vk)
        self.tabBar.barTintColor = .systemGray6
        self.tabBar.backgroundColor = .systemGray6
    }
}
