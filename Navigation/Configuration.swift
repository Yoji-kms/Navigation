//
//  Configuration.swift
//  Navigation
//
//  Created by Yoji on 02.03.2023.
//

import UIKit

enum Configuration {
    static let viewControllerBackgroundColor: UIColor = {
#if DEBUG
        return .systemGray6
#else
        return .systemBlue
#endif
    }()
    
    static let userService: UserService = {
#if DEBUG
        return TestUserService()
#else
        return CurrentUserService()
#endif
    }()
}
