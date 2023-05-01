//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import StorageService

final class ProfileViewModel: ProfileViewModelProtocol {
    enum State {
        case initial
    }
    
    enum ViewInput {
        case photosDidTap([UIImage])
    }
    
    let user: UserModel
    let posts: [Post]
    let photos: [UIImage]
    
    
    weak var coordinator: ProfileCoordinator?
    
    init(user: UserModel) {
        self.user = user
        self.photos = StorageService.shared.photos
        self.posts = StorageService.shared.posts
    }
    
    func updateState(viewInput: ProfileViewModel.ViewInput) {
        switch viewInput {
        case .photosDidTap(let data):
            self.coordinator?.pushPhotosViewController(data: data)
        }
    }
}
