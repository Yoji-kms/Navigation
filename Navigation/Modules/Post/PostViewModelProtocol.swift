//
//  PostViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation
import StorageService

protocol PostViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: PostViewModel.ViewInput)
    
    var post: Post? { get }
}
