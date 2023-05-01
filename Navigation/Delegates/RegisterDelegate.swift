//
//  CheckerServiceDelegate.swift
//  Navigation
//
//  Created by Yoji on 19.04.2023.
//

import Foundation

protocol RegisterDelegate: AnyObject {
    func register(login: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
}
