//
//  FeedModel.swift
//  Navigation
//
//  Created by Yoji on 05.03.2023.
//

import Foundation

final class FeedModel: FeedModelProtocol {
    private let secretWord = "pswrd"
    
    func check(word: String) -> Bool {
        return word == secretWord
    }
}
