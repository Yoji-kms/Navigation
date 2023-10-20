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
        case removeFromFavorite(Int)
        case filterBtnDidTap((String?)->())
        case unfilterBtnDidTap
    }
    
    let postDataManager: PostDataManager
    private(set) var data: [Post] = []
    
    weak var coordinator: FavoriteCoordinator?
    
    init(postDataManager: PostDataManager) {
        self.postDataManager = postDataManager
        
        postDataManager.fetchFavoritePosts()
        self.refreshData()
    }
    
    func updateState(viewInput: FavoriteViewModel.ViewInput) {
        switch viewInput {
        case .refreshData:
            self.refreshData()
        case .removeFromFavorite(let index):
            self.postDataManager.removePostFromFavorite(atIndex: index)
            self.data.remove(at: index)
        case .filterBtnDidTap(let completion):
            self.coordinator?.presentFilterAlertController { filterString in
                let filteredPosts = self.postDataManager.getFilteredPosts(byAuthor: filterString)
                if !filteredPosts.isEmpty {
                    self.data = filteredPosts.map { $0.toPost() }
                    completion(filterString)
                } else {
                    completion(nil)
                }
            }
        case .unfilterBtnDidTap:
            self.refreshData()
        }
    }
    
    private func refreshData() {
        self.data = self.postDataManager.favoritePosts.map { $0.toPost() }
    }
}
