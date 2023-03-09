//
//  PostViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation
import StorageService

final class PostViewModel: PostViewModelProtocol {    
    let post: Post?
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case infoBtnDidTap
        case didReturnFromInfoViewController(Coordinatable)
    }
    
    weak var coordinator: PostCoordinator?
    
    private(set) var state: State = .initial
    
    init(post: Post?) {
        self.post = post
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .infoBtnDidTap:
            self.coordinator?.presentInfoViewController()
        case .didReturnFromInfoViewController(let infoCoordinator):
            self.coordinator?.didReturnFromInfoViewController(coordinator: infoCoordinator)
        }
    }
}
