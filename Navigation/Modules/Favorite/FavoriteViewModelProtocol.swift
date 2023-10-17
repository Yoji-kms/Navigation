//
//  FavoriteViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import Foundation
import StorageService

protocol FavoriteViewModelProtocol: ViewModelProtocol {
    var data: [Post] { get }
    func updateState(viewInput: FavoriteViewModel.ViewInput)
}
