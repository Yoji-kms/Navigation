//
//  CustomButton.swift
//  Navigation
//
//  Created by Yoji on 05.03.2023.
//

import UIKit

final  class CustomButton: UIButton {
// MARK: Variables
    private var onBtnTap: () -> Void
    
// MARK: Lifecycle
    init(title: String?, titleColor: UIColor?, backgroundColor: UIColor?, onBtnTap: @escaping () -> Void) {
        self.onBtnTap = onBtnTap
        super.init(frame: .zero)
        self.basicSetup(title: title, titleColor: titleColor)
        self.backgroundColor = backgroundColor
    }
    
    init(title: String?, titleColor: UIColor?, backgroundImage: UIImage?, onBtnTap: @escaping () -> Void) {
        self.onBtnTap = onBtnTap
        super.init(frame: .zero)
        self.basicSetup(title: title, titleColor: titleColor)
        self.setBackgroundImage(backgroundImage, for: .normal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Actions
    @objc private func buttonTapped() {
        self.onBtnTap()
    }
    
// MARK: Methods
    private func basicSetup(title: String?, titleColor: UIColor?) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
