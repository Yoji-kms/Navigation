//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Yoji on 05.08.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    private lazy var statusText = ""
    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 64
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Some name"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusSetBtn: UIButton = {
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
    
    lazy var status: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Some status"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newStatusTextField: UITextField = {
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
        status.text = statusText
        if (newStatusTextField.isFirstResponder) {
            newStatusTextField.resignFirstResponder()
        }
    }
    
    
    private func setupViews() {
        self.addSubview(avatar)
        NSLayoutConstraint.activate([
            self.avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatar.heightAnchor.constraint(equalToConstant: 128),
            self.avatar.widthAnchor.constraint(equalToConstant: 128),
        ])
        
        self.addSubview(name)
        NSLayoutConstraint.activate([
            self.name.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.name.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 8),
            self.name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.name.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        self.addSubview(statusSetBtn)
        NSLayoutConstraint.activate([
            self.statusSetBtn.heightAnchor.constraint(equalToConstant: 50),
            self.statusSetBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.statusSetBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusSetBtn.topAnchor.constraint(equalTo: self.avatar.bottomAnchor, constant: 16)
        ])
        
        self.addSubview(newStatusTextField)
        NSLayoutConstraint.activate([
            self.newStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            self.newStatusTextField.leadingAnchor.constraint(equalTo: self.name.leadingAnchor),
            self.newStatusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.newStatusTextField.bottomAnchor.constraint(equalTo: self.statusSetBtn.topAnchor, constant: -16)
        ])
        
        self.addSubview(status)
        NSLayoutConstraint.activate([
            self.status.heightAnchor.constraint(equalToConstant: 14),
            self.status.leadingAnchor.constraint(equalTo: self.name.leadingAnchor),
            self.status.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.status.bottomAnchor.constraint(equalTo: self.newStatusTextField.topAnchor, constant: -16)
        ])
    }
}
