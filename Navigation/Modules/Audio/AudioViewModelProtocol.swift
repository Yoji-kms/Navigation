//
//  AudioViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 19.03.2023.
//

import Foundation

protocol AudioViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: AudioViewModel.ViewInput)
    
    var audio: String { get }
    var playlist: [String] { get }
    var isPlaying: Bool { get }
}
