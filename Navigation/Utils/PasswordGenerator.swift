//
//  PasswordGenerator.swift
//  Navigation
//
//  Created by Yoji on 11.03.2023.
//

import Foundation

final class PasswordGenerator {
    private init(){}
    
    public static var shared = PasswordGenerator()
    
    func generatePassword(length: Int) -> String {
        let symbols = String().printable
        let password = String((0 ..< length).map { _ in
            symbols.randomElement() ?? Character("")
        })
        Checker.shared.password = password
        
        return password
    }
}
