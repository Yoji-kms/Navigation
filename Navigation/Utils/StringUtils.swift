//
//  StringUtils.swift
//  Navigation
//
//  Created by Yoji on 18.11.2024.
//

import Foundation

extension String {
    var localized: String {
        return String(localized: String.LocalizationValue(self))
    }
}
