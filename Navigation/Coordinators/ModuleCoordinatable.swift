//
//  ModuleCoordinatable.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

protocol ModuleCoordinatable: Coordinatable {
    var module: Module? { get }
    var moduleType: Module.ModuleType { get }
}
