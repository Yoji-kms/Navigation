//
//  UIVIewUtils.swift
//  Navigation
//
//  Created by Yoji on 18.03.2023.
//

import UIKit

extension UIView {
    /// Sets height and width to 0
    func hide() {
        self.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.widthAnchor.constraint(equalToConstant: 0).isActive = true
    }
    
    /// Makes view height and width scaled by coefficient
    func scale(by coefficient: CGFloat) {
        self.transform = CGAffineTransform(scaleX: coefficient, y: coefficient)
    }
}
