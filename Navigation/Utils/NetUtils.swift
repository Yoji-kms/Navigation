//
//  NetUtils.swift
//  Navigation
//
//  Created by Yoji on 25.03.2023.
//

import Foundation

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
                    print("🔵\(dataString ?? "")")
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
    
    func handleAsJson() async -> Any? {
        do {
            guard let url = URL(string: self) else {
                return nil
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let dictionary = try JSONSerialization.jsonObject(with: data)
            guard let castedDictionary = dictionary as? [String: Any] else {
                return nil
            }
            return castedDictionary["title"]
        } catch {
            print("♦️\(error)")
            return nil
        }
    }
    
    func handleAsDecodable <T: Decodable>() async -> T? {
        do {
            guard let url = URL(string: self) else {
                return nil
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print("♦️\(error)")
            return nil
        }
    }
}

extension Sequence {
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}
