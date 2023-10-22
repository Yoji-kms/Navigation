//
//  Post.swift
//  Navigation
//
//  Created by Yoji on 02.07.2022.
//

import Foundation

public struct Post {
    public init(title: String, description: String, author: String, image: String, likes: Int, views: Int) {
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
    public let image: String
    public let likes: Int
    public let views: Int
}
