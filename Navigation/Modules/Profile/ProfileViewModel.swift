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
        case postDidDoubleTap(Int)
    }
    
    let user: User
    let posts: [Post]
    let photos: [UIImage]
    private let postDataManager: PostDataManager
    
    weak var coordinator: ProfileCoordinator?
    
    init(user: User, postDataManager: PostDataManager) {
        self.user = user
        self.photos = StorageService.shared.photos
        self.posts = StorageService.shared.posts
        self.postDataManager = postDataManager
    }
    
    func updateState(viewInput: ProfileViewModel.ViewInput) {
        switch viewInput {
        case .photosDidTap(let data):
            self.coordinator?.pushPhotosViewController(data: data)
        case .postDidDoubleTap(let index):
            self.postDataManager.addFavoritePost(posts[index])
        }
    }
}
