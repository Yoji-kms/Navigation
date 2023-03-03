//
//  TestUserService.swift
//  Navigation
//
//  Created by Yoji on 03.03.2023.
//

import UIKit
import StorageService

class TestUserService: UserService {
    private lazy var user: User = {
        let user = User(
            login: "testUser",
            fullName: "testFullName",
            avatar: UIImage(named: "avatar") ?? UIImage(),
            status: "testStatus"
        )
        return user
    }()
    
    func getUser(login: String) -> User? {
        return (user.login == login) ? user : nil
    }
}
