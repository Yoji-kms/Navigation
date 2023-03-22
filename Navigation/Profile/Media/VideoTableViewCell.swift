//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Yoji on 18.03.2023.
//

import UIKit

final class VideoTableViewCell: UITableViewCell {
    weak var delegate: VideoTapDelegate?
    private var link: String?
    
    private lazy var video: CustomButton = {
        let btn = CustomButton(
            title: nil,
            titleColor: .black,
            onBtnTap: videoDidTap
        )
        btn.setImage(UIImage(systemName: "play.rectangle.fill"), for: .normal)
        btn.imageView?.tintColor = .systemRed
        btn.titleLabel?.numberOfLines = 1
        btn.titleLabel?.lineBreakMode = .byClipping
        btn.contentHorizontalAlignment = .leading
        
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
            self.video.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.video.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.video.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.video.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setup(with viewModel: (String, String)) {
        self.video.setTitle(viewModel.0, for: .normal)
        self.link = viewModel.1
    }
    
    
    private func videoDidTap() {
        guard let link = self.link else {
            return
        }
        delegate?.videoDidTap(link)
    }
}
