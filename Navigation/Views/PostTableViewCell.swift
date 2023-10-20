//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Yoji on 28.09.2022.
//

import UIKit
import StorageService

final class PostTableViewCell: UITableViewCell {
    var indexPath: IndexPath?
// MARK: Views
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var views: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
// MARK: Overriding functions
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.title.text = nil
        self.postDescription.text = nil
        self.views.text = nil
        self.likes.text = nil
    }
  
// MARK: Setups
    func setup(with viewModel: Post) {
        self.image.image = UIImage(named: viewModel.image)
        self.title.text = viewModel.title
        self.postDescription.text = viewModel.description
        self.likes.text = NSLocalizedString("Likes", comment: "Likes") + String(viewModel.likes)
        self.views.text = NSLocalizedString("Views", comment: "Views") + String(viewModel.views)
    }
    
    func setupViews() {
        self.contentView.addSubview(title)
        self.contentView.addSubview(image)
        self.contentView.addSubview(postDescription)
        self.contentView.addSubview(views)
        self.contentView.addSubview(likes)
        
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.image.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 16),
            self.image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 1.0),
            
            self.postDescription.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 16),
            self.postDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.postDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.likes.topAnchor.constraint(equalTo: self.postDescription.bottomAnchor, constant: 16),
            self.likes.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.likes.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            
            self.views.topAnchor.constraint(equalTo: self.postDescription.bottomAnchor, constant: 16),
            self.views.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.views.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}

