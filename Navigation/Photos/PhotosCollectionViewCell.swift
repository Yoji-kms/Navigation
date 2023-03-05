//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Yoji on 18.11.2022.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.image?.jpegData(compressionQuality: 0.2)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.photo.image = nil
    }
    
    func setup(with viewModel: UIImage) {
        self.photo.image = viewModel
    }
    
    private func setupView() {
        self.addSubview(photo)
        
        NSLayoutConstraint.activate([
            self.photo.topAnchor.constraint(equalTo: self.topAnchor),
            self.photo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photo.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
