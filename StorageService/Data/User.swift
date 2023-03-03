//
//  User.swift
//  StorageService
//
//  Created by Yoji on 03.03.2023.
//

import UIKit

public struct User {
    public init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
    public let login: String
    public let fullName: String
    public let avatar: UIImage
    public let status: String
}
