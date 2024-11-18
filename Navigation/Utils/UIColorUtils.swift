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
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return .init { traitCollection -> UIColor in
            traitCollection.userInterfaceStyle == .dark ? darkMode : lightMode
        }
    }
}

enum Colors {
    case light
    case dark
    case background
    case border
    
    var color: UIColor {
        return switch self {
        case .light:
                .createColor(lightMode: .white, darkMode: .black)
        case .dark:
                .createColor(lightMode: .black, darkMode: .white)
        case .background:
                .createColor(lightMode: .white, darkMode: .black)
        case .border:
                .createColor(lightMode: .black, darkMode: .white)
        }
    }
}
