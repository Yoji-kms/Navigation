//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Yoji on 18.11.2022.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {
// MARK: Variables
    private var images: [UIImage] = []
    private let imagePublisherFacade = ImagePublisherFacade()
    private let viewModel: PhotosViewModelProtocol
    
// MARK: Views
    private lazy var photosCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var photosCollectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: photosCollectionViewLayout)
        colView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        colView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        colView.dataSource = self
        colView.delegate = self
        colView.translatesAutoresizingMaskIntoConstraints = false
        return colView
    }()
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.setupView()
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imagePublisherFacade.removeSubscription(for: self)
    }
    
    init(viewModel: PhotosViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Setups
    private func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = NSLocalizedString("Photo Galery", comment: "Photo Galery")
        self.navigationItem.backButtonTitle = NSLocalizedString("Back", comment: "Back")
    }
    
    private func setupView() {
        self.view.addSubview(photosCollectionView)
        
        NSLayoutConstraint.activate([
            self.photosCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.photosCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.photosCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.photosCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupData() {
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: viewModel.data.count, userImages: viewModel.data)
    }
}

// MARK: Extensions
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let offsets: CGFloat = 4 * 8
        let cellWidth = (screenWidth - offsets) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.setup(with: images[indexPath.row])
        
        return cell
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.images = images
        self.photosCollectionView.performBatchUpdates {
            let index = IndexPath(row: images.count - 1, section: 0)
            self.photosCollectionView.insertItems(at: [index])
        }
    }
}
