//
//  Module.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

struct Module {
    enum TabType {
        case profile
        case feed
    }
    
    enum ModuleType {
        case profile(UserModel)
        case feed
        case login
        case post(Post?)
        case info
        case register
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let viewController: UIViewController
}

extension Module.TabType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .profile:
            let title = NSLocalizedString("Profile", comment: "Profile")
            let image: UIImage = UIImage(systemName: "person.fill") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 1)
        case .feed:
            let title = NSLocalizedString("Feed", comment: "Feed")
            let image: UIImage = UIImage(systemName: "lanyardcard.fill") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 0)
        }
    }
}
