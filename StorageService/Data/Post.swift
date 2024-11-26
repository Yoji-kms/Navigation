//
//  Post.swift
//  Navigation
//
//  Created by Yoji on 02.07.2022.
//

import UIKit

public struct Post {
    public init(title: String, description: String, author: String, image: String, likes: Int, views: Int) {
        self.title = title
        self.description = description
        self.author = author
        self.image = UIImage(named: image) ?? UIImage()
        self.likes = likes
        self.views = views
    }
    
    public init(title: String, description: String, author: String, image: UIImage, likes: Int, views: Int) {
        self.title = title
        self.description = description
        self.author = author
        self.image = image
        self.likes = likes
        self.views = views
    }
    
    public let title: String
    public let description: String
    public let author: String
    public let image: UIImage
    public let likes: Int
    public let views: Int
}
