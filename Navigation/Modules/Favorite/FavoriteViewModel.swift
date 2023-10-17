//
//  FavoriteViewModel.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import UIKit
import StorageService

final class FavoriteViewModel: FavoriteViewModelProtocol {
    enum ViewInput {
        case refreshData
    }
    
    let postDataManager: PostDataManager
    private(set) var data: [Post]
    
    weak var coordinator: FavoriteCoordinator?
    
    init(postDataManager: PostDataManager) {
        self.postDataManager = postDataManager
        
        postDataManager.fetchFavoritePosts()
        self.data = postDataManager.favoritePosts.map { $0.toPost() }
    }
    
    func updateState(viewInput: FavoriteViewModel.ViewInput) {
        switch viewInput {
        case .refreshData:
            self.data = postDataManager.favoritePosts.map { $0.toPost() }
        }
    }
}
