//
//  InfoViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

protocol InfoViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: InfoViewModel.ViewInput)
}
