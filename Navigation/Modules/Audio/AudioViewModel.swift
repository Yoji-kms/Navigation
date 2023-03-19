//
//  AudioViewModel.swift
//  Navigation
//
//  Created by Yoji on 19.03.2023.
//

import Foundation
import AVFoundation

final class AudioViewModel: AudioViewModelProtocol {
    private lazy var player = AVAudioPlayer()
    let playlist: [String]
    var audio: String
    var isPlaying: Bool = false
    
    init(audio: String, playlist: [String]) {
        self.audio = audio
        self.playlist = playlist
        self.playAudio(self.audio)
    }
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case backBtnDidTap
        case playPauseBtnDidTap
        case stopBtnDidTap
        case forwardBtnDidTap
        case closePlayer
    }
    
    private(set) var state: State = .initial
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .backBtnDidTap:
            self.backBtnDidTap()
        case .playPauseBtnDidTap:
            self.playBtnDidTap()
        case .stopBtnDidTap:
            self.stopBtnDidTap()
        case .forwardBtnDidTap:
            self.forwardBtnDidTap()
        case .closePlayer:
            self.player.stop()
        }
    }
    
    private func playAudio(_ name: String) {
        do {
            self.player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!))
            self.player.prepareToPlay()
            self.player.play()
            self.isPlaying = self.player.isPlaying
        }
        catch {
            print(error)
        }
    }
    
    private func playBtnDidTap() {
        if self.player.isPlaying {
            self.player.stop()
        } else {
            self.player.play()
        }
        self.isPlaying = self.player.isPlaying
    }
    
    private func stopBtnDidTap() {
        self.player.stop()
        self.player.currentTime = 0
        self.isPlaying = self.player.isPlaying
    }
    
    private func forwardBtnDidTap() {
        let index: Int = (self.playlist.firstIndex(of: self.audio) ?? 0) + 1
        self.audio = index < self.playlist.count ? self.playlist[index] : self.playlist[0]
        self.playAudio(self.audio)
    }
    
    private func backBtnDidTap() {
        let index: Int = (self.playlist.firstIndex(of: self.audio) ?? 0) - 1
        guard let lastTrack = self.playlist.last else {
            return
        }
        self.audio = index >= 0 ? self.playlist[index] : lastTrack
        self.playAudio(self.audio)
    }
}
