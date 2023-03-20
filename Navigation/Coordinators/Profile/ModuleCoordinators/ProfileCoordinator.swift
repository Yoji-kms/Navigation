//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import AVFoundation
import AVKit

final class ProfileCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = self.factory.makeModule(ofType: self.moduleType)
        let viewController = module.viewController
        (module.viewModel as? ProfileViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushPhotosViewController(data: [UIImage]) {
        let viewModel = PhotosViewModel(data: data)
        let viewControllerToPush = PhotosViewController(viewModel: viewModel)
        self.module?.viewController.navigationController?.pushViewController(viewControllerToPush, animated: true)
    }
    
    func presentAudioViewController(audio: String, playlist: [String]) {
        let viewModel = AudioViewModel(audio: audio, playlist: playlist)
        let viewControllerToPresent = AudioViewController(viewModel: viewModel)
        self.module?.viewController.present(viewControllerToPresent, animated: true)
    }
    
    func presentAVPlayerViewController(urlString: String) {
        let viewModel = VideoViewModel(data: urlString)
        let viewControllerToPresent = VideoViewController(viewModel: viewModel)
        self.module?.viewController.present(viewControllerToPresent, animated: true)
    }
}
