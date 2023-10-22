//
//  FavoriteViewModel.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import UIKit
import StorageService
import CoreData

final class FavoriteViewModel: FavoriteViewModelProtocol {
    enum ViewInput {
        case refreshData
        case removeFromFavorite(PostData)
        case filterBtnDidTap((String?)->())
        case unfilterBtnDidTap
    }
    
    let postDataManager: PostDataManager
    let fetchController: NSFetchedResultsController<PostData>
    
    weak var coordinator: FavoriteCoordinator?
    
    init(postDataManager: PostDataManager) {
        self.postDataManager = postDataManager
        self.fetchController = postDataManager.fetchController
        try? self.postDataManager.fetchController.performFetch()
    }
    
    func updateState(viewInput: FavoriteViewModel.ViewInput) {
        switch viewInput {
        case .refreshData:
            try? self.postDataManager.fetchController.performFetch()
        case .removeFromFavorite(let post):
            self.postDataManager.removePostFromFavorite(post)
        case .filterBtnDidTap(let completion):
            self.coordinator?.presentFilterAlertController { filterString in
                self.postDataManager.filterPosts(byAuthor: filterString)
                let filteredPosts = self.postDataManager.fetchController.fetchedObjects ?? []
                if !filteredPosts.isEmpty {
                    completion(filterString)
                } else {
                    self.postDataManager.unfilterData()
                    try? self.postDataManager.fetchController.performFetch()
                    completion(nil)
                }
            }
        case .unfilterBtnDidTap:
            self.postDataManager.unfilterData()
            try? self.postDataManager.fetchController.performFetch()
        }
    }
}
