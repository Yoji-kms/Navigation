//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Yoji on 05.08.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    private lazy var statusText = ""
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 64
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Some name"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = .init(genericCMYKCyan: 1, magenta: 0, yellow: 0, black: 1, alpha: 1)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Some status"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0, yellow: 0, black: 1, alpha: 1)
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(showKeybord(_:)), for: .touchUpInside)
        return textField
    }()
    
    init() {
        super.init(frame: CGRect())
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showKeybord(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? "Unknown"
    }
    
    @objc func buttonPressed(){
        statusLabel.text = statusText
        if (statusTextField.isFirstResponder) {
            statusTextField.resignFirstResponder()
        }
    }
    
    
    private func setupViews() {
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
        self.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 128),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 128),
       
            self.fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.fullNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 8),
            self.fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.fullNameLabel.heightAnchor.constraint(equalToConstant: 18),

            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16),

            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.fullNameLabel.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusTextField.bottomAnchor.constraint(equalTo: self.setStatusButton.topAnchor, constant: -16),

            self.statusLabel.heightAnchor.constraint(equalToConstant: 14),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.fullNameLabel.leadingAnchor),
            self.statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusLabel.bottomAnchor.constraint(equalTo: self.statusTextField.topAnchor, constant: -16),
        ])
    }
}
