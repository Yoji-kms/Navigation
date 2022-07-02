//
//  InfoViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var button: UIButton = {
        let windowHeight = self.view.frame.height
        let windowWidth = self.view.frame.width
        let button = UIButton(frame: CGRect(x: 16, y: windowHeight - 106, width: windowWidth - 32, height: 50))
        button.backgroundColor = .systemMint
        button.setTitle("Print message", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height/4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Info"
        self.view.backgroundColor = .lightGray
        self.view.addSubview(button)
    }
    
    @objc private func didTapButton(){
        let alertController = UIAlertController(title: "Print message?", message: nil, preferredStyle: .alert)
        let printMessage = UIAlertAction(title: "Print", style: .default, handler: { _ in print("Message") })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(printMessage)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
