//
//  UIImageUtils.swift
//  Navigation
//
//  Created by Yoji on 03.03.2023.
//

import UIKit

extension UIImage {
func alpha(_ value:CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
    }
}
