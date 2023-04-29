//
//  RegisterViewController.swift
//  Navigation
//
//  Created by Yoji on 29.04.2023.
//

import UIKit

final class RegisterViewController: UIViewController {
    private let viewModel: RegisterViewModel
    
//    MARK: Views
    private lazy var registerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = NSLocalizedString("Enter your creds", comment: "Enter your creds")
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 22)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.leadingPadding(8)
        textField.placeholder = NSLocalizedString("Email", comment: "Email")
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.setBorder(color: UIColor.lightGray.cgColor, width: 0.5, cornerRadius: nil)
        textField.addTarget(self, action: #selector(loginTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.leadingPadding(8)
        textField.placeholder = NSLocalizedString("Password", comment: "Password")
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.setBorder(color: UIColor.lightGray.cgColor, width: 0.5, cornerRadius: nil)
        textField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var registerBtn: CustomButton = {
        let title = NSLocalizedString("Register", comment: "Register")
        let btn = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: UIColor.systemGreen,
            onBtnTap: didTapRegisterBtn
        )
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        btn.validateViaTxtFields([self.loginTextField, self.passwordTextField])
        return btn
    }()
    
    private lazy var cancelBtn: CustomButton = {
        let title = NSLocalizedString("Cancel", comment: "Cancel")
        let btn = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: UIColor.systemRed,
            onBtnTap: didTapCancelBtn
        )
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        return btn
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
   
//    MARK: Inits
    init(registerViewModel: RegisterViewModel) {
        self.viewModel = registerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Lifecycle
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
    
//    MARK: Setups
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        self.view.addSubview(self.scrollView)

        self.scrollView.addSubview(self.registerLbl)
        self.scrollView.addSubview(self.logInStackView)
        self.scrollView.addSubview(self.registerBtn)
        self.scrollView.addSubview(self.cancelBtn)
        
        self.logInStackView.addArrangedSubview(self.loginTextField)
        self.logInStackView.addArrangedSubview(self.passwordTextField)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.registerLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            self.registerLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.registerLbl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.logInStackView.topAnchor.constraint(equalTo: self.registerLbl.bottomAnchor, constant: 16),
            self.logInStackView.heightAnchor.constraint(equalToConstant: 100),
            self.logInStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.logInStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.loginTextField.widthAnchor.constraint(equalTo: self.logInStackView.widthAnchor),
            
            self.passwordTextField.widthAnchor.constraint(equalTo: self.logInStackView.widthAnchor),
            
            self.registerBtn.topAnchor.constraint(equalTo: self.logInStackView.bottomAnchor, constant: 16),
            self.registerBtn.heightAnchor.constraint(equalToConstant: 50),
            self.registerBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.registerBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.cancelBtn.topAnchor.constraint(equalTo: self.registerBtn.bottomAnchor, constant: 16),
            self.cancelBtn.heightAnchor.constraint(equalToConstant: 50),
            self.cancelBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.cancelBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
//    MARK: Actions
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            
            let loginBtnBottomPointY = self.cancelBtn.frame.origin.y + self.cancelBtn.frame.height
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
    
    private func didTapRegisterBtn() {
        let login = self.loginTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        self.viewModel.updateState(
            viewInput: .registerBtnDidTap(login, password) { result in
                switch result {
                case .success():
                    self.dismiss(animated: true)
                case .failure(.emailAlreadyInUse):
                    self.clearTextFields()
                    let message = NSLocalizedString("Email already in use", comment: "Email already in use")
                    AlertUtils.showUserMessage(message, context: self)
                case .failure(.invalidEmail):
                    self.clearTextFields()
                    let message = NSLocalizedString("Invalid email", comment: "Invalid email")
                    AlertUtils.showUserMessage(message, context: self)
                case .failure(.weakPassword):
                    self.passwordTextField.text = ""
                    let message = NSLocalizedString("Weak password", comment: "Weak password")
                    AlertUtils.showUserMessage(message, context: self)
                case .failure(let error):
                    print("🔴\(error)")
                }
            }
        )
    }
    
    private func didTapCancelBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func loginTextChanged(){
        self.registerBtn.validateViaTxtFields([self.loginTextField, self.passwordTextField])
    }
    
    @objc private func passwordTextChanged(){
        self.registerBtn.validateViaTxtFields([self.loginTextField, self.passwordTextField])
    }
    
    private func clearTextFields() {
        self.loginTextField.text = ""
        self.passwordTextField.text = ""
    }
}
