//
//  CurrentUserService.swift
//  StorageService
//
//  Created by Yoji on 03.03.2023.
//

import UIKit
import StorageService

class CurrentUserService: UserService {
    private lazy var user: UserModel = {
        let user = UserModel(
            login: "someUser",
            fullName: "someFullName",
            avatar: UIImage(named: "avatar") ?? UIImage(),
            status: "someStatus"
        )
        return user
    }()
    
    func getUser(login: String) -> UserModel? {
        return (user.login == login) ? user : nil
    }
}
