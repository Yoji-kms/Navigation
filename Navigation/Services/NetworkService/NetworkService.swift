//
//  NetworkService.swift
//  Navigation
//
//  Created by Yoji on 23.03.2023.
//

import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) async -> Any? {
        switch configuration {
        case .filmDataEp1:
            configuration.rawValue.handleAsUrl()
        case .filmDataEp2:
            configuration.rawValue.handleAsUrl()
        case .filmDataEp3:
            configuration.rawValue.handleAsUrl()
        case .todo:
            return await configuration.rawValue.handleAsJson()
        case .planetsDataEp1:
            let planet: Planet? = await configuration.rawValue.handleAsDecodable()
            return planet
        }
        return nil
    }
}
