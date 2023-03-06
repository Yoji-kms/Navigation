//
//  PhotosTableViewHeader.swift
//  Navigation
//
//  Created by Yoji on 18.11.2022.
//

import UIKit

final class PhotosCollectionViewHeader: UICollectionReusableView {
// MARK: Views
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Photos", comment: "Photos")
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var forward: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
// MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Setups
    private func setupViews() {
        self.addSubview(label)
        self.addSubview(forward)
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            self.forward.centerYAnchor.constraint(equalTo: self.label.centerYAnchor),
            self.forward.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        ])
    }
}
