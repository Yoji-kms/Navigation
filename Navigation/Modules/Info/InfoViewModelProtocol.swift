//
//  InfoViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

protocol InfoViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((InfoViewModel.State) -> Void)? { get set }
    
    func updateState(viewInput: InfoViewModel.ViewInput)
    func updateStateNet(task: InfoViewModel.NetworkHandle) async -> Any?
}
