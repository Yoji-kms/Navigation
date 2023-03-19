//
//  StrartPlayerDelegate.swift
//  Navigation
//
//  Created by Yoji on 19.03.2023.
//

import Foundation

protocol StartPlayerDelegate: AnyObject {
    func start(audio: String, playlist: [String])
}
