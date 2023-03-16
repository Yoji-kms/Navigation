//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit
import iOSIntPackage

final class PhotosViewModel: PhotosViewModelProtocol {
    var data: [UIImage] = []
    private let inputData: [UIImage]
    var isAllImagesFiltered: Bool
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case updatePhotos
    }
    
    init(data: [UIImage]) {
        self.inputData = data
        self.isAllImagesFiltered = false
        self.setupData()
    }
    
    private func setupData() {
        let imageProcessor = ImageProcessor()
        inputData.forEach { image in
            imageProcessor.processImagesOnThread(sourceImages: [image], filter: .posterize, qos: .utility) { photo in
                guard let filteredPhoto = photo.convertToUIImage().first else { return }
                self.data.append(filteredPhoto)
                self.isAllImagesFiltered = self.data.count == self.inputData.count
            }
        }
    }
}
