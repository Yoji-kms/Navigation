//
//  AudioTableViewCell.swift
//  Navigation
//
//  Created by Yoji on 18.03.2023.
//

import UIKit

final class AudioTableViewCell: UITableViewCell {
    weak var delegate: AudioTapDelegate?
    
    private lazy var audio: CustomButton = {
        let btn = CustomButton(
            title: nil,
            titleColor: .systemBlue,
            onBtnTap: audioDidTap
        )
        btn.titleLabel?.numberOfLines = 1
        btn.titleLabel?.lineBreakMode = .byClipping
        btn.contentHorizontalAlignment = .leading
        btn.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        
        return btn
    }()
    
    // MARK: Lifecycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    override func prepareForReuse() {
        self.setupView()
    }
    
    private func setupView() {
        self.contentView.addSubview(audio)
        
        NSLayoutConstraint.activate([
            self.audio.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.audio.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.audio.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.audio.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func setup(with viewModel: String) {
        self.audio.setTitle(viewModel, for: .normal)
    }
    
    
    private func audioDidTap() {
        guard let name = self.audio.currentTitle else {
            return
        }
        delegate?.audioDidTap(name: name)
    }
}
