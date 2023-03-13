//
//  UnlockPasswordOperation.swift
//  Navigation
//
//  Created by Yoji on 11.03.2023.
//

import Foundation

final class UnlockPasswordOperation: Operation {
    var password: String
    var unlockedPassword: String?
    
    init(password: String) {
        self.password = password
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        unlockedPassword = PasswordUnlocker.shared.bruteForce(passwordToUnlock: self.password)
    }
}
