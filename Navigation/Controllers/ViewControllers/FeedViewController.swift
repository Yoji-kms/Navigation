//
//  FeedViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

class FeedViewController: UIViewController {
    private lazy var button: UIButton = {
        let windowHeight = self.view.frame.height
        let windowWidth = self.view.frame.width
        let button = UIButton(frame: CGRect(x: 16, y: windowHeight - 106, width: windowWidth - 32, height: 50))
        button.backgroundColor = .systemCyan
        button.setTitle("Show post", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height/4
        return button
    }()
    
    @objc private func didTapButton(){
        let postVC = PostViewController()
        postVC.post = self.post
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    private lazy var post: Post = Post(title: "Post title")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed"
        self.view.backgroundColor = .white
        
        self.view.addSubview(button)
    }
}
