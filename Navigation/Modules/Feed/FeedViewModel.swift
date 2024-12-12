//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation
import StorageService

final class FeedViewModel: FeedViewModelProtocol {
    enum State {
        case initial
    }
    
    enum ViewInput {
        case showPostBtnDidTap(Post?)
        case didReturnFromPostViewController(Coordinatable)
    }
    
    weak var coordinator: FeedCoordinator?
    
    let post: Post
    let feedModel: FeedModelProtocol
    
    init() {
        self.post = Post(title: "Post title", description: "", author: "", image: "", likes: 0, views: 0)
        self.feedModel = FeedModel()
    }
    
    func updateState(viewInput: FeedViewModel.ViewInput) {
        switch viewInput {
        case .showPostBtnDidTap(let post):
            self.coordinator?.pushPostViewController(post: post)
        case .didReturnFromPostViewController(let postCoordinator):
            self.coordinator?.didReturnFromPostViewController(coordinator: postCoordinator)
        }
    }
    
    func checkGuess(word guessWord: String) -> Bool {
        return feedModel.check(word: guessWord)
    }
}
