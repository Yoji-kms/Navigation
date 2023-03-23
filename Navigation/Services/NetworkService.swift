//
//  NetworkService.swift
//  Navigation
//
//  Created by Yoji on 23.03.2023.
//

import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        switch configuration {
        case .filmDataEp1:
            configuration.rawValue.handleAsUrl()
        case .filmDataEp2:
            configuration.rawValue.handleAsUrl()
        case .filmDataEp3:
            configuration.rawValue.handleAsUrl()
        }
    }
}

extension String {
    func handleAsUrl() {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: self) else {
                return
            }
            let urlRequest = URLRequest(url: url)
            let urlSession = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let dataString = String(data: data, encoding: .utf8)
                    print("🔵\(dataString)")
                }
                if let response = response as? HTTPURLResponse {
                    print("🟡\(response.statusCode)")
                    print("🟡\(response.allHeaderFields)")
                }
                print("🔴\(error.debugDescription)")
            }
            urlSession.resume()
        }
    }
}
