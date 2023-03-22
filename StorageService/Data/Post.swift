//
//  Post.swift
//  Navigation
//
//  Created by Yoji on 02.07.2022.
//

import Foundation

public struct Post {
    public init(
        title: String,
        description: String? = nil,
        image: String? = nil,
        audio: [String] = [],
        video: [(String, String)] = [],
        likes: Int,
        views: Int
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.audio = audio
        self.video = video
        self.likes = likes
        self.views = views
    }
    
    public let title: String
    public let description: String?
    public let image: String?
    public let audio: [String]
    public let video: [(String, String)]
    public let likes: Int
    public let views: Int
}
