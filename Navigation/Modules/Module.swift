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
        case favorite
    }
    
    enum ModuleType {
        case profile(User)
        case feed
        case login
        case post(Post?)
        case info
        case favorite
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let viewController: UIViewController
}

extension Module.TabType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .feed:
            let title = "Feed".localized
            let image: UIImage = UIImage(systemName: "lanyardcard.fill") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 0)
        case .profile:
            let title = "Profile".localized
            let image: UIImage = UIImage(systemName: "person.fill") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 1)
        case .favorite:
            let title = "Favorite".localized
            let image: UIImage = UIImage(systemName: "star.circle.fill") ?? UIImage()
            return UITabBarItem(title: title, image: image, tag: 2)
        }
    }
}
