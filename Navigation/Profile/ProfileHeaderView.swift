//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Yoji on 05.08.2022.
//

import UIKit
import StorageService

final class ProfileHeaderView: UITableViewHeaderFooterView {
// MARK: Variables
    private lazy var statusText = ""
    
    weak var delegate: AvatarTapDelegate?
    
// MARK: Views
    private lazy var avatarView: AvatarView = {
        let view = AvatarView()
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(avatarDidTap(tapGestureRecogniser:)))
        
        view.addGestureRecognizer(tapGestureRecogniser)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = NSLocalizedString("Some name", comment: "Name")
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setStatusButton: CustomButton = {
        let title = NSLocalizedString("Set status", comment: "Set status")
        let button = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: .systemBlue.notEnabled(),
            onBtnTap: buttonDidTap
        )
        button.isEnabled = false
        button.layer.cornerRadius = 4
        button.layer.shadowColor = .init(genericCMYKCyan: 1, magenta: 0, yellow: 0, black: 1, alpha: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = NSLocalizedString("Some status", comment: "Status")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.leadingPadding(8)
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.setBorder(color: UIColor.black.cgColor, width: 1, cornerRadius: 12)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
// MARK: Inits
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Setups
    func setup(with user: User) {
        self.fullNameLabel.text = user.fullName
        self.avatarView.avatarImageView.image = user.avatar
        self.statusLabel.text = user.status
    }
    
    private func setupViews() {
        self.addSubview(avatarView)
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
        self.addSubview(statusLabel)
        self.bringSubviewToFront(avatarView)
        
        NSLayoutConstraint.activate([
            self.avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarView.heightAnchor.constraint(equalToConstant: 128),
            self.avatarView.widthAnchor.constraint(equalToConstant: 128),
       
            self.fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.fullNameLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            self.fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.fullNameLabel.heightAnchor.constraint(equalToConstant: 18),

            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16),

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
    
// MARK: Actions
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? NSLocalizedString("Unknown", comment: "Unknown")
        if (textField.text == "") {
            setStatusButton.isEnabled = false
            setStatusButton.backgroundColor = .systemBlue.notEnabled()
            setStatusButton.layer.shadowOpacity = 0.1
        } else {
            setStatusButton.isEnabled = true
            setStatusButton.backgroundColor = .systemBlue
            setStatusButton.layer.shadowOpacity = 0.7
        }
    }
    
    func buttonDidTap(){
        statusLabel.text = statusText
        self.statusTextField.text = ""
        self.endEditing(true)
    }
    
    @objc func avatarDidTap(tapGestureRecogniser: UITapGestureRecognizer) {
        guard let tapped = tapGestureRecogniser.view as? AvatarView else { return }

        delegate?.avatarTap(avatar: tapped)
    }
}
