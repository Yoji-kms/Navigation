//
//  PostViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit


class PostViewController: UIViewController {
    var post: Post?
    private lazy var barButton = UIBarButtonItem(
        image: UIImage(systemName: "info.circle"),
        style: .plain,
        target: self,
        action: #selector(didTapButton)
    )
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
        self.navigationItem.title = post?.title
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func didTapButton(){
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .popover
        infoVC.modalTransitionStyle = .crossDissolve
        
        self.present(infoVC, animated: true, completion: nil)
    }
}
