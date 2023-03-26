//
//  Planet.swift
//  Navigation
//
//  Created by Yoji on 24.03.2023.
//

import Foundation

struct Planet: Decodable {
    let orbitalPeriod: String
    let residents: [String]
}
