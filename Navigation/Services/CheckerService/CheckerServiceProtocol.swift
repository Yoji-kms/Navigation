//
//  CheckerServiceProtocol.swift
//  Navigation
//
//  Created by Yoji on 19.04.2023.
//

import Foundation
import StorageService

protocol CheckerServiceProtocol {
    func signUp(login: String, password: String, completion: @escaping (Result <UserModel, FirebaseError>) -> Void)
    func checkCredentials(login: String, password: String, completion: @escaping (Result <UserModel, FirebaseError>) -> Void)
    func signOut()
}
