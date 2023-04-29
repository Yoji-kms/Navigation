//
//  CheckerService.swift
//  Navigation
//
//  Created by Yoji on 19.04.2023.
//

import Foundation
import StorageService
import FirebaseAuth

final class CheckerService: CheckerServiceProtocol {
    func signUp(login: String, password: String, completion: @escaping (Result <UserModel, FirebaseError>) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) {[weak self] (authData, error) in
            guard let strongSelf = self else { return }
            strongSelf.handleFirResponse(authData: authData, error: error, completion: completion)
        }
    }
    
    func checkCredentials(login: String, password: String, completion: @escaping (Result <UserModel, FirebaseError>) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authData, error in
            guard let strongSelf = self else { return }
            strongSelf.handleFirResponse(authData: authData, error: error, completion: completion)
        }
    }
    
    func signOut() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch {
                print("🔴\(error)")
            }
        }
    }
    
    private func handleFirResponse(authData: AuthDataResult?, error: Error?, completion: @escaping (Result <UserModel, FirebaseError>) -> Void) {
        if let error = error as NSError? {
            let errorCode = AuthErrorCode(_nsError: error)
            switch errorCode.code {
            case .wrongPassword:
                completion(.failure(.wrongPassword))
            case .invalidEmail:
                completion(.failure(.invalidEmail))
            case .emailAlreadyInUse:
                completion(.failure(.emailAlreadyInUse))
            case .userNotFound:
                completion(.failure(.userNotFound))
            case .weakPassword:
                completion(.failure(.weakPassword))
            default:
                print("🔴\(errorCode)")
            }
            return
        }
        let firUser = authData?.user
        let login = firUser?.email ?? ""
        guard let index = login.firstIndex(of: "@") else { return }
        let length = login.distance(from: login.startIndex, to: index)
        let fullName = login.padding(toLength: length, withPad: "", startingAt: 0)
        let user = UserModel(login: login, fullName: fullName)
        print("🟢\(user)")
        completion(.success(user))
    }
}
