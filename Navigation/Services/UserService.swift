//
//  UserService.swift
//  StorageService
//
//  Created by Yoji on 03.03.2023.
//

import Foundation
import StorageService

protocol UserService {
    func getUser(login: String) -> User?
}
