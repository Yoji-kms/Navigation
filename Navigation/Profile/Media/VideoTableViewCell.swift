//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Yoji on 18.03.2023.
//

import UIKit

final class VideoTableViewCell: UITableViewCell {
    private lazy var video: CustomButton = {
        let btn = CustomButton(
            title: nil,
            titleColor: .systemBlue,
            onBtnTap: videoDidTap
        )
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
        self.video.setTitle(nil, for: .normal)
    }
    
    private func setupView() {
        self.contentView.addSubview(video)
        
        NSLayoutConstraint.activate([
            self.video.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.video.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.video.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.video.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setup(with viewModel: String) {
        self.video.setTitle(viewModel, for: .normal)
    }
    
    
    private func videoDidTap() {
        
    }
}
