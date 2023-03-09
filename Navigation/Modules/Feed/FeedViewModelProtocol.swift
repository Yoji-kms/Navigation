//
//  FeedViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation
import StorageService

protocol FeedViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: FeedViewModel.ViewInput)
    
    var post: Post { get }
    func checkGuess(word guessWord: String) -> Bool
}
