//
//  InfoViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

final class InfoViewModel: InfoViewModelProtocol {
    enum State {
        case initial
    }
    
    enum ViewInput {
        case printMessageBtnDidTap
    }
    
    weak var coordinator: InfoCoordinator?
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .printMessageBtnDidTap:
            self.coordinator?.presentAlert()
        }
    }
}
