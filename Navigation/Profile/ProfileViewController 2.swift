//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeaderView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        NSLayoutConstraint.activate([
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
