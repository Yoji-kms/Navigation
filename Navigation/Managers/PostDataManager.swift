//
//  PostDataManager.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import CoreData
import StorageService

final class PostDataManager {
    lazy var persistentContaner: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsListModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                print("🔴 Core data error: \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        let context = persistentContaner.viewContext
        return context
    }()
    
    private(set) var favoritePosts: [PostData] = []
    
    init() {
        self.fetchFavoritePosts()
    }
    
    enum Action {
        case add(Post)
        case remove(Int)
    }
    
    func fetchFavoritePosts() {
        let fetchRequest = PostData.fetchRequest()
        self.favoritePosts = (try? context.fetch(fetchRequest)) ?? []
    }
    
    func addFavoritePost(_ post: Post) {
        self.handleFavoritePost(.add(post))
    }
    
    func removePostFromFavorite(atIndex index: Int) {
        self.handleFavoritePost(.remove(index))
    }
    
    private func handleFavoritePost(_ action: Action) {
        switch action {
        case .add(let post):
            if !favoritePosts.contains(where: { $0.postDescription == post.description }) {
                let dbPost = PostData(context: self.context)
                dbPost.title = post.title
                dbPost.postDescription = post.description
                dbPost.image = post.image
                dbPost.likes = Int16(post.likes)
                dbPost.views = Int32(post.views)
            }
        case .remove(let index):
            self.context.delete(favoritePosts[index])
        }
        do {
            try self.context.save()
            self.fetchFavoritePosts()
        } catch {
            print("🔴\(error)")
        }
    }
}
