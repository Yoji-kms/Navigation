//
//  ProfileViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

protocol ProfileViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: ProfileViewModel.ViewInput)
    
    var user: User { get }
    var photos: [UIImage] { get }
    var posts: [Post] { get }
}
