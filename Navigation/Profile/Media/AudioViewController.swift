//
//  AudioViewController.swift
//  Navigation
//
//  Created by Yoji on 19.03.2023.
//

import UIKit

final class AudioViewController: UIViewController {
// MARK: Variables
    private let viewModel: AudioViewModelProtocol

//    MARK: Views
    private lazy var audioNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textAlignment = .left
        lbl.text = self.viewModel.audio
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var playPauseBtn: UIButton = {
        let btn = CustomButton(title: nil,
                               titleColor: nil,
                               backgroundImage: UIImage(systemName: "pause.fill"),
                               onBtnTap: playBtnDidTap)
        btn.tintColor = .black
        btn.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        return btn
    }()
    
    private lazy var stopBtn: UIButton = {
        let btn = CustomButton(title: nil,
                               titleColor: nil,
                               backgroundImage: UIImage(systemName: "stop.fill"),
                               onBtnTap: stopBtnDidTap)
        btn.tintColor = .black
        btn.transform = CGAffineTransform(scaleX: 2, y: 2)
        btn.isEnabled = true
        
        return btn
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = CustomButton(title: nil,
                               titleColor: nil,
                               backgroundImage: UIImage(systemName: "backward.end.fill"),
                               onBtnTap: backBtnDidTap)
        btn.tintColor = .black
        btn.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        return btn
    }()
    
    private lazy var forwardBtn: UIButton = {
        let btn = CustomButton(title: nil,
                               titleColor: nil,
                               backgroundImage: UIImage(systemName: "forward.end.fill"),
                               onBtnTap: forwardBtnDidTap)
        btn.tintColor = .black
        btn.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var panelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
//    MARK: Lifecycle
    init(viewModel: AudioViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewModel.updateState(viewInput: .closePlayer)
    }
    
//    MARK: Setups
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(audioNameLbl)
        self.stackView.addArrangedSubview(panelStackView)
        
        self.panelStackView.addArrangedSubview(backBtn)
        self.panelStackView.addArrangedSubview(playPauseBtn)
        self.panelStackView.addArrangedSubview(stopBtn)
        self.panelStackView.addArrangedSubview(forwardBtn)
        
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.audioNameLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            self.panelStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            self.panelStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
    }
    
// MARK: Actions
    private func playBtnDidTap() {
        if self.viewModel.isPlaying {
            self.playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            self.playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            self.stopBtn.isEnabled = true
        }
        self.viewModel.updateState(viewInput: .playPauseBtnDidTap)
    }
    
    private func stopBtnDidTap() {
        self.viewModel.updateState(viewInput: .stopBtnDidTap)
        self.playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        self.stopBtn.isEnabled = false
    }
    
    private func backBtnDidTap() {
        self.viewModel.updateState(viewInput: .backBtnDidTap)
        self.audioNameLbl.text = self.viewModel.audio
    }
    
    private func forwardBtnDidTap() {
        self.viewModel.updateState(viewInput: .forwardBtnDidTap)
        self.audioNameLbl.text = self.viewModel.audio
    }
}
