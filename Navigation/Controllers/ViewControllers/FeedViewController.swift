//
//  FeedViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController {
// MARK: Variables
    private lazy var post: Post = Post(title: "Post title", description: "", image: "", likes: 0, views: 0)
    private let feedModel = FeedModel()
    
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
        let title = NSLocalizedString("Show post", comment: "Show post")
        let button = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: .systemCyan,
            onBtnTap: didTapShowPostBtn
        )
        return button
    }()
    
    private lazy var guessTxtField: UITextField = {
        let txtField = UITextField()
        txtField.leadingPadding(8)
        txtField.font = .systemFont(ofSize: 16)
        txtField.textColor = .black
        txtField.setBorder(color: UIColor.black.cgColor, width: 0.5, cornerRadius: 12)
        txtField.placeholder = NSLocalizedString("Enter your guess", comment: "Enter your guess")
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let title = NSLocalizedString("Check guess", comment: "Check guess")
        let btn = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: .systemIndigo,
            onBtnTap: didTapGuessBtn
        )
        return btn
    }()
    
    private lazy var checkGuessLabel: UILabel = {
        let lbl = UILabel()
        lbl.alpha = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
// MARK: Actions
    private func didTapShowPostBtn(){
        let postVC = PostViewController()
        postVC.post = self.post
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    private func didTapGuessBtn() {
        guard let guessText = guessTxtField.text else { return }
        let guessed = feedModel.check(word: guessText)
        let correct = NSLocalizedString("Correct", comment: "Correct")
        let incorrect = NSLocalizedString("Incorrect", comment: "Incorrect")
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
 
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Feed", comment: "Feed")
        self.view.backgroundColor = .white

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
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
}
