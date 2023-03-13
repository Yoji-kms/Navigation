//
//  LogInViewController.swift
//  Navigation
//
//  Created by Yoji on 28.09.2022.
//


import UIKit

final class LogInViewController: UIViewController{
    private let viewModel: LoginViewModelProtocol
    
// MARK: Views
    private lazy var vkLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private lazy var emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.text = viewModel.defaultLogin
        textField.leadingPadding(8)
        textField.placeholder = NSLocalizedString("Email or phone", comment: "Email or phone")
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.setBorder(color: UIColor.lightGray.cgColor, width: 0.5, cornerRadius: nil)
        textField.addTarget(self, action: #selector(loginTextChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
//        textField.text = viewModel.defaultPassword
        textField.leadingPadding(8)
        textField.placeholder = NSLocalizedString("Password", comment: "Password")
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.setBorder(color: UIColor.lightGray.cgColor, width: 0.5, cornerRadius: nil)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.insertSubview(self.activityIndicator, at: 1)
        return textField
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
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
            onBtnTap: didTapLogInBtn
        )
        btn.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .disabled)
        btn.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .highlighted)
        btn.setBackgroundImage(UIImage(named: "blue_pixel")?.alpha(0.8), for: .selected)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        btn.isEnabled = !(emailOrPhoneTextField.text?.isEmpty ?? true)
        return btn
    }()
    
    private lazy var unlockPasswordBtn: CustomButton = {
        let title = NSLocalizedString("Unlock password", comment: "Unlock password")
        let btn = CustomButton(title: title,
                               titleColor: nil,
                               backgroundColor: .systemGreen,
                               onBtnTap: didTapUnlockPasswordBtn)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
// MARK: Init
    init(loginViewModel: LoginViewModel) {
        self.viewModel = loginViewModel
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
        self.scrollView.addSubview(unlockPasswordBtn)
        
        self.logInStackView.addArrangedSubview(emailOrPhoneTextField)
        self.logInStackView.addArrangedSubview(passwordTextField)
        
        self.passwordTextField.addSubview(self.activityIndicator)
        
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
            
            self.unlockPasswordBtn.topAnchor.constraint(equalTo: logInBtn.bottomAnchor, constant: 16),
            self.unlockPasswordBtn.heightAnchor.constraint(equalToConstant: 50),
            self.unlockPasswordBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.unlockPasswordBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 16),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.passwordTextField.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
        ])
    }
    
// MARK: Actions
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            
            let btnBottomPointY = self.unlockPasswordBtn.frame.origin.y + self.unlockPasswordBtn.frame.height
            let keyboardOriginY = self.view.safeAreaLayoutGuide.layoutFrame.height - keyboardHeight
        
            let yOffset = keyboardOriginY < btnBottomPointY
            ? btnBottomPointY - keyboardOriginY + 16
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
    
    private func didTapLogInBtn() {
        let login = self.emailOrPhoneTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        self.viewModel.updateState(viewInput: .loginBtnDidTap(login, password))
    }
    
    private func didTapUnlockPasswordBtn() {
        self.activityIndicator.startAnimating()
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        
        let startTime = Date.now
        self.viewModel.updateState(viewInput: .unlockPasswordBtnDidTap)
        guard let unlockPasswordOperation = self.viewModel.operation else {
            return
        }
        
        let passwordUnlockedOperation = BlockOperation {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.passwordTextField.text = self.viewModel.password
                self.passwordTextField.isSecureTextEntry = false
                let timeInteval = Date().timeIntervalSince(startTime)
                print("🔶\(timeInteval)")
            }
        }
        
        passwordUnlockedOperation.addDependency(unlockPasswordOperation)
        
        let operations = [unlockPasswordOperation, passwordUnlockedOperation]
        
        queue.addOperations(operations, waitUntilFinished: false)
    }
    
    @objc private func loginTextChanged(_ textField: UITextField){
        self.logInBtn.isEnabled = (self.emailOrPhoneTextField.text != "")
    }
}
