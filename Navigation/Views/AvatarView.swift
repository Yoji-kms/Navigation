//
//  AvatarView.swift
//  Navigation
//
//  Created by Yoji on 04.02.2023.
//

import UIKit

final class AvatarView: UIView {
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 64
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 1)
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var fadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func removeAnimations(){
        print("AAAAAA")
        self.fadingView.layer.removeAllAnimations()
        self.avatarImageView.layer.removeAllAnimations()
        print("AAAAAA")

    }
    
    private func setupViews() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.fadingView)
        self.sendSubviewToBack(self.fadingView)
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.fadingView.topAnchor.constraint(equalTo: self.topAnchor),
            self.fadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.fadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.fadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
