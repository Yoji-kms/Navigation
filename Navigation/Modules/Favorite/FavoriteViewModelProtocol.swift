//
//  FavoriteViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import StorageService
import CoreData

protocol FavoriteViewModelProtocol: ViewModelProtocol {
    var fetchController: NSFetchedResultsController<PostData> { get }
    func updateState(viewInput: FavoriteViewModel.ViewInput)
}
