//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

final class InfoCoordinator: ModuleCoordinatable {
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
        (module.viewModel as? InfoViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "Print message?".localized, message: nil, preferredStyle: .alert)
        let printMessage = UIAlertAction(title: "Print".localized, style: .default, handler: { _ in
            print("Message".localized)
        })
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alertController.addAction(printMessage)
        alertController.addAction(cancel)
        
        self.module?.viewController.present(alertController, animated: true)
    }
}
