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
    
    func getFilteredPosts(byAuthor author: String) -> [PostData] {
        if self.favoritePosts.contains(where: { $0.author?.lowercased() == author.lowercased() }) {
            let fetchRequest = PostData.fetchRequest()
            let predicate = NSPredicate(format: "author ==[c] %@", author)
            fetchRequest.predicate = predicate
            return (try? context.fetch(fetchRequest) as [PostData]) ?? []
        }
        
        return []
    }
    
    func fetchFavoritePosts() {
        let fetchRequest = PostData.fetchRequest()
        self.favoritePosts = (try? context.fetch(fetchRequest) as [PostData]) ?? []
    }
    
    func addFavoritePost(_ post: Post) {
        self.handleFavoritePost(.add(post))
    }
    
    func removePostFromFavorite(atIndex index: Int) {
        self.handleFavoritePost(.remove(index))
    }
    
    private func handleFavoritePost(_ action: Action) {
        self.persistentContaner.performBackgroundTask { [weak self] backgroundContext in
            guard let strongSelf = self else { return }
            switch action {
            case .add(let post):
                if !strongSelf.favoritePosts.contains(where: { $0.postDescription == post.description }) {
                    let dbPost = PostData(context: backgroundContext)
                    dbPost.title = post.title
                    dbPost.postDescription = post.description
                    dbPost.author = post.author
                    dbPost.image = post.image.description
                    dbPost.likes = Int16(post.likes)
                    dbPost.views = Int32(post.views)
                }
            case .remove(let index):
                guard let post = 
                        backgroundContext.object(with: strongSelf.favoritePosts[index].objectID) as? PostData else {
                    return
                }
                backgroundContext.delete(post)
            }
            do {
                try backgroundContext.save()
                strongSelf.fetchFavoritePosts()
            } catch {
                print("🔴\(error)")
            }
        }
    }
}
