//
//  LogInViewController.swift
//  Navigation
//
//  Created by Yoji on 28.09.2022.
//


import UIKit
import StorageService

final class LogInViewController: UIViewController{
    var loginDelegate: LoginViewControllerDelegate?
// MARK: Views
    private lazy var vkLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private lazy var emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = NSLocalizedString("Email or phone", comment: "Email or phone")
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.addTarget(self, action: #selector(loginTextChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = NSLocalizedString("Password", comment: "Password")
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var logInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.automaticallyAdjustsScrollIndicatorInsets = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logInBtn: CustomButton = {
        let title = NSLocalizedString("Log in", comment: "Log in")
        let btn = CustomButton(
            title: title,
            titleColor: nil,
            backgroundImage: UIImage(named: "blue_pixel")?.alpha(1),
            onBtnTap: didTapBtn
        )
        btn.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .disabled)
        btn.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .highlighted)
        btn.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .selected)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        btn.isEnabled = false
        return btn
    }()
    
// MARK: Init
    init(loginInspector: LoginInspector) {
        loginDelegate = loginInspector
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
// MARK: Setups
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        self.view.addSubview(scrollView)

        self.scrollView.addSubview(vkLogo)
        self.scrollView.addSubview(logInStackView)
        self.scrollView.addSubview(logInBtn)
        
        self.logInStackView.addArrangedSubview(emailOrPhoneTextField)
        self.logInStackView.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.vkLogo.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            self.vkLogo.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.vkLogo.heightAnchor.constraint(equalToConstant: 100),
            self.vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            self.logInStackView.topAnchor.constraint(equalTo: self.vkLogo.bottomAnchor, constant: 120),
            self.logInStackView.heightAnchor.constraint(equalToConstant: 100),
            self.logInStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.logInStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.emailOrPhoneTextField.widthAnchor.constraint(equalTo: self.logInStackView.widthAnchor),
            
            self.passwordTextField.widthAnchor.constraint(equalTo: self.logInStackView.widthAnchor),
            
            self.logInBtn.topAnchor.constraint(equalTo: logInStackView.bottomAnchor, constant: 16),
            self.logInBtn.heightAnchor.constraint(equalToConstant: 50),
            self.logInBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.logInBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
// MARK: Actions
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            
            let loginBtnBottomPointY = self.logInBtn.frame.origin.y + self.logInBtn.frame.height
            let keyboardOriginY = self.view.safeAreaLayoutGuide.layoutFrame.height - keyboardHeight
        
            let yOffset = keyboardOriginY < loginBtnBottomPointY
            ? loginBtnBottomPointY - keyboardOriginY + 16
            : 0
            
            self.scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: true)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func didTapBtn() {
        let login = self.emailOrPhoneTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let currentUserService = Configuration.userService
        guard let user = currentUserService.getUser(login: login) else {
            showUserMessage(NSLocalizedString("User does not exist", comment: "User does not exist"))
            return
        }
        if loginDelegate?.check(login: login, password: password) ?? false {
            let profileVC = ProfileViewController()
            profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else {
            showUserMessage(NSLocalizedString("Incorrect password", comment: "Incorrect password"))
        }
    }
    
    @objc private func loginTextChanged(_ textField: UITextField){
        self.logInBtn.isEnabled = (self.emailOrPhoneTextField.text != "")
    }
    
    private func showUserMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil) })
    }
}
