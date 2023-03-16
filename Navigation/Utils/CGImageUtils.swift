//
//  CGImageUtils.swift
//  Navigation
//
//  Created by Yoji on 16.03.2023.
//

import UIKit

extension Array<CGImage?> {
    func convertToUIImage() -> [UIImage] {
        return self.compactMap { image -> UIImage in
            guard let image = image else { fatalError("Error filtering image") }
            return UIImage(cgImage: image)
        }
    }
}
