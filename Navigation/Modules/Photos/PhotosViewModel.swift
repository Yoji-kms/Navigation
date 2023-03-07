//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

final class PhotosViewModel: PhotosViewModelProtocol {
    let data: [UIImage]
    
    init(data: [UIImage]) {
        self.data = data
    }
}
