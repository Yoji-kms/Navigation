//
//  FeedViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    private lazy var post: Post = Post(title: "Post title", description: "", image: "", likes: 0, views: 0)
    
// MARK: Views
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle(NSLocalizedString("Show post", comment: "Show post"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle(NSLocalizedString("Show post", comment: "Show post"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
// MARK: Actions
    @objc private func didTapButton(){
        let postVC = PostViewController()
        postVC.post = self.post
        self.navigationController?.pushViewController(postVC, animated: true)
    }
 
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Feed", comment: "Feed")
        self.view.backgroundColor = .white

        setupViews()
    }
    
// MARK: Setups
    private func setupViews() {
        self.view.addSubview(stackView)
        
        self.stackView.addArrangedSubview(firstButton)
        self.stackView.addArrangedSubview(secondButton)
        
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            self.firstButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.firstButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.firstButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.secondButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.secondButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.secondButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.firstButton.layer.cornerRadius = self.firstButton.frame.height/4
        self.secondButton.layer.cornerRadius = self.secondButton.frame.height/4
    }
}
