//
//  PhotosViewModelProtocol.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import UIKit

protocol PhotosViewModelProtocol: ViewModelProtocol {
    var data: [UIImage] { get }
    var isAllImagesFiltered: Bool { get }
}
