//
//  InfoViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//
//
import UIKit

final class InfoViewController: UIViewController {
// MARK: Views
    private lazy var button: UIButton = {
        let title = NSLocalizedString("Print message", comment: "Print message")
        let button = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: .systemMint,
            onBtnTap: didTapButton
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Info"
        self.view.backgroundColor = .lightGray
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.button.layer.cornerRadius = self.button.frame.height/4
    }
    
    private func setupViews() {
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func didTapButton(){
        let alertController = UIAlertController(title: NSLocalizedString("Print message?", comment: "Print message?"), message: nil, preferredStyle: .alert)
        let printMessage = UIAlertAction(title: NSLocalizedString("Print", comment: "Print"), style: .default, handler: { _ in
            print(NSLocalizedString("Message", comment: "Message"))
        })
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
        
        alertController.addAction(printMessage)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
