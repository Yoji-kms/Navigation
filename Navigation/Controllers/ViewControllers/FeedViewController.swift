//
//  FeedViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

final class FeedViewController: UIViewController {
// MARK: Variables
    private let viewModel: FeedViewModelProtocol
    
// MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.automaticallyAdjustsScrollIndicatorInsets = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var showPostButton: CustomButton = {
        let title = "Show post".localized
        let button = CustomButton(
            title: title,
            titleColor: Colors.light.color,
            backgroundColor: .systemCyan,
            onBtnTap: didTapShowPostBtn
        )
        return button
    }()
    
    private lazy var guessTxtField: UITextField = {
        let txtField = UITextField()
        txtField.leadingPadding(8)
        txtField.font = .systemFont(ofSize: 16)
        txtField.textColor = Colors.dark.color
        
        txtField.placeholder = "Enter your guess".localized
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let title = "Check guess".localized
        let btn = CustomButton(
            title: title,
            titleColor: Colors.light.color,
            backgroundColor: .systemIndigo,
            onBtnTap: didTapGuessBtn
        )
        return btn
    }()
    
    private lazy var checkGuessLabel: UILabel = {
        let lbl = UILabel()
        lbl.alpha = 0
        lbl.textAlignment = .center
        lbl.textColor = Colors.light.color
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
// MARK: Actions
    private func didTapShowPostBtn(){
        let post = self.viewModel.post
        self.viewModel.updateState(viewInput: .showPostBtnDidTap(post))
    }
    
    private func didTapGuessBtn() {
        guard let guessText = guessTxtField.text else { return }
        let guessed = viewModel.checkGuess(word: guessText)
        let correct = "Correct".localized
        let incorrect = "Incorrect".localized
        self.checkGuessLabel.text = guessed ? correct : incorrect
        self.checkGuessLabel.backgroundColor = guessed ? .systemGreen : .systemRed
        UIView.animate(withDuration: 0.5) {
            self.checkGuessLabel.alpha = 1
        }
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            
            let stackViewBottomPointY = self.stackView.frame.origin.y + self.stackView.frame.height
            let keyboardOriginY = self.view.safeAreaLayoutGuide.layoutFrame.height - keyboardHeight
        
            let yOffset = keyboardOriginY < stackViewBottomPointY
            ? stackViewBottomPointY - keyboardOriginY + 16
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
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed".localized
        self.view.backgroundColor = Colors.background.color

        self.setupViews()
        self.setupGestures()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.showPostButton.layer.cornerRadius = self.showPostButton.frame.height/4
        self.checkGuessButton.layer.cornerRadius = self.checkGuessButton.frame.height/4
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateCgColors()
    }
    
// MARK: Setups
    private func setupViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(stackView)
        
        self.stackView.addArrangedSubview(showPostButton)
        self.stackView.addArrangedSubview(guessTxtField)
        self.stackView.addArrangedSubview(checkGuessButton)
        self.stackView.addArrangedSubview(checkGuessLabel)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 200),
            self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: -200),
            
            self.showPostButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.showPostButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.showPostButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.guessTxtField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.guessTxtField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.guessTxtField.heightAnchor.constraint(equalToConstant: 50),
            
            self.checkGuessButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.checkGuessButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.checkGuessLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.checkGuessLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.checkGuessLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        self.updateCgColors()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func updateCgColors() {
        self.guessTxtField.setBorder(color: Colors.border.color.cgColor, width: 0.5, cornerRadius: 12)
    }
}

extension FeedViewController: RemoveChildCoordinatorDelegate {
    func remove(childCoordinator: Coordinatable) {
        self.viewModel.updateState(viewInput: .didReturnFromPostViewController(childCoordinator))
    }
}
