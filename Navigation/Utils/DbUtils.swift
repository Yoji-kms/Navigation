//
//  DbUtils.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import Foundation
import StorageService

extension PostData {
    func toPost() -> Post {
        let post = Post(
            title: self.title ?? "",
            description: self.postDescription ?? "",
            image: self.image ?? "",
            likes: Int(self.likes),
            views: Int(self.views)
        )
        return post
    }
}
