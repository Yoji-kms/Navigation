//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Yoji on 05.08.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    private lazy var statusText = ""
    
    weak var delegate: AvatarTapDelegat?

    
    private lazy var avatarView: AvatarView = {
        let view = AvatarView()
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(avatarTap(tapGestureRecogniser:)))
        
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
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .systemGray
        button.isEnabled = false
        button.backgroundColor = .systemBlue.notEnabled()
        button.setTitle(NSLocalizedString("Set status", comment: "Set status"), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = .init(genericCMYKCyan: 1, magenta: 0, yellow: 0, black: 1, alpha: 1)
        button.layer.shadowOpacity = 0.1
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
        label.text = NSLocalizedString("Some status", comment: "Status")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15)
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = .init(genericCMYKCyan: 1, magenta: 0, yellow: 0, black: 1, alpha: 1)
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    @objc func buttonPressed(){
        statusLabel.text = statusText
        self.endEditing(true)
    }
    
    @objc func avatarTap(tapGestureRecogniser: UITapGestureRecognizer) {
        guard let tapped = tapGestureRecogniser.view as? AvatarView else { return }

        delegate?.avatarTap(avatar: tapped)
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
}

extension UIColor {
    func notEnabled() -> UIColor? {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor (
                hue: hue, saturation: min(saturation - 0.6, 1.0), brightness: brightness, alpha: alpha
            )
        } else {
            return nil
        }
    }
}
