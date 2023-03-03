//
//  UIColorUtils.swift
//  Navigation
//
//  Created by Yoji on 03.03.2023.
//

import UIKit

extension UIColor {
    func notEnabled() -> UIColor? {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor (
                hue: hue, saturation: min(saturation - 0.6, 1.0), brightness: brightness, alpha: alpha
            )
        } else {
            return nil
        }
    }
}
