//
//  InfoViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//
//
import UIKit

final class InfoViewController: UIViewController {
    private let viewModel: InfoViewModelProtocol
    weak var delegate: RemoveChildCoordinatorDelegate?
// MARK: Views
    private lazy var button: UIButton = {
        let title = NSLocalizedString("Print message", comment: "Print message")
        let button = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: .systemMint,
            onBtnTap: didTapButton
        )
        return button
    }()
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Info"
        self.view.backgroundColor = .lightGray
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.button.layer.cornerRadius = self.button.frame.height/4
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let coordinator = (self.viewModel as? InfoViewModel)?.coordinator else {
            return
        }
        delegate?.remove(childCoordinator: coordinator)
    }
    
    init(viewModel: InfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Setups
    private func setupViews() {
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
// MARK: Actions
    private func didTapButton(){
        self.viewModel.updateState(viewInput: .printMessageBtnDidTap)
    }
}
