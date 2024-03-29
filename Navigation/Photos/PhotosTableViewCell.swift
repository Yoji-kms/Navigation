//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Yoji on 18.11.2022.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    private lazy var data: [UIImage] = []
    
// MARK: Views
    private lazy var photosCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 100, height: 48)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var photosCollectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionViewLayout)
        colView.register(
            PhotosCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "PhotosCollectionViewHeader"
        )
        colView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "DefaultHeader"
        )
        colView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        colView.contentInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        colView.dataSource = self
        colView.delegate = self
        colView.translatesAutoresizingMaskIntoConstraints = false
        return colView
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
    
// MARK: Setups
    func setup(with viewModel: [UIImage]) {
       data = viewModel
    }

    private func setupView() {
        self.contentView.addSubview(photosCollectionView)
        
        let cellHeight = photosCollectionViewLayout.headerReferenceSize.height + photosCollectionViewLayout.itemSize.height + 64

        NSLayoutConstraint.activate([
            self.photosCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photosCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.photosCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.photosCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.photosCollectionView.heightAnchor.constraint(equalToConstant: cellHeight)
        ])
    }
}

// MARK: Extensions
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.bounds.width
        let numOfItems: CGFloat = 4
        let offsets: CGFloat = 2 * 12 + 3 * 8
        let cellWidth = (screenWidth - offsets) / numOfItems
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.clipsToBounds = true
            return cell
        }
        let photo = data[indexPath.row]
        cell.setup(with: photo)
        cell.layer.cornerRadius = 6
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PhotosCollectionViewHeader", for: indexPath) as? PhotosCollectionViewHeader else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DefaultHeader", for: indexPath)
                return header
            }
            return header
        default:
            assert(false, "Invalid element type")
        }
        return UICollectionReusableView()
    }
}
