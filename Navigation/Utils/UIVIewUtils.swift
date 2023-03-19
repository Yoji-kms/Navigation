//
//  UIVIewUtils.swift
//  Navigation
//
//  Created by Yoji on 18.03.2023.
//

import UIKit

extension UIView {
    func remove() {
        self.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.widthAnchor.constraint(equalToConstant: 0).isActive = true
    }
}
