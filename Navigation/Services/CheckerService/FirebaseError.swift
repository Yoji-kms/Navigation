//
//  FirebaseError.swift
//  Navigation
//
//  Created by Yoji on 28.04.2023.
//

import Foundation

enum FirebaseError: Error {
    case userNotFound
    case wrongPassword
    case invalidEmail
    case emailAlreadyInUse
    case weakPassword
}
