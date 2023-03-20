//
//  VideoViewModel.swift
//  Navigation
//
//  Created by Yoji on 19.03.2023.
//

import Foundation

final class VideoViewModel: VideoViewModelProtocol {
    let video: String
    
    enum State {
        case initial
    }
    
    init(data: String) {
        self.video = data
    }
}
