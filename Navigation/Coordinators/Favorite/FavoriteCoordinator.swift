//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import UIKit

final class FavoriteCoordinator: ModuleCoordinatable {
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
        (module.viewModel as? FavoriteViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func presentFilterAlertController(completion: @escaping (String) -> Void) {
        let controllerTitle = "Filter by author".localized
        let alert = UIAlertController(title: controllerTitle, message: nil, preferredStyle: .alert)
        
        let cancelActionTitle = "Cancel".localized
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        
        let createActionTitle = "Filter".localized
        let createAction = UIAlertAction(title: createActionTitle, style: .default) { _ in
            completion(alert.textFields?.first?.text ?? "")
        }
        createAction.isEnabled = !(alert.textFields?.first?.text?.isEmpty ?? true)
        
        let textChangedAction = UIAction { _ in
            guard let text = alert.textFields?.first?.text else { return }
            createAction.isEnabled = !text.isEmpty
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Author placeholder".localized
            textField.addAction(textChangedAction, for: .editingChanged)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        self.module?.viewController.present(alert, animated: true)
    }
}
