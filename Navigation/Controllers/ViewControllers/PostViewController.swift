//
//  PostViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

final class PostViewController: UIViewController {
    private let viewModel: PostViewModelProtocol
    weak var delegate: RemoveChildCoordinatorDelegate?
    
    private lazy var barButton = UIBarButtonItem(
        image: UIImage(systemName: "info.circle"),
        style: .plain,
        target: self,
        action: #selector(didTapButton)
    )
        
    init(viewModel: PostViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
        self.navigationItem.title = viewModel.post?.title
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let coordinator = (self.viewModel as? PostViewModel)?.coordinator else {
            return
        }
        delegate?.remove(childCoordinator: coordinator)
    }
    
    @objc private func didTapButton(){
        viewModel.updateState(viewInput: .infoBtnDidTap)
    }
}

extension PostViewController: RemoveChildCoordinatorDelegate {
    func remove(childCoordinator: Coordinatable) {
        self.viewModel.updateState(viewInput: .didReturnFromInfoViewController(childCoordinator))
    }
}
