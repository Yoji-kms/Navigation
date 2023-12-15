//
//  PostDataManager.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import CoreData
import StorageService

final class PostDataManager {
    lazy var fetchController: NSFetchedResultsController = {
        let fetchRequest = PostData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "author", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return controller
    }()
    
    
    private lazy var persistentContaner: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsListModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                print("🔴 Core data error: \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        let context = self.persistentContaner.newBackgroundContext()
        return context
    }()
    
    init() {
        try? self.fetchController.performFetch()
    }
    
    enum Action {
        case add(Post)
        case remove(PostData)
    }
    
    func filterPosts(byAuthor author: String) {
        let predicate = NSPredicate(format: "author CONTAINS[c] %@", author)
        self.fetchController.fetchRequest.predicate = predicate
        try? self.fetchController.performFetch()
    }
    
    func unfilterData() {
        self.fetchController.fetchRequest.predicate = nil
        try? self.fetchController.performFetch()
    }
    
    func addFavoritePost(_ post: Post) {
        self.handleFavoritePost(.add(post))
    }
    
    func removePostFromFavorite(_ post: PostData) {
        self.handleFavoritePost(.remove(post))
    }
    
    private func handleFavoritePost(_ action: Action) {
        switch action {
        case .add(let post):
            if !(self.fetchController.fetchedObjects ?? []).contains(where: {
                $0.postDescription == post.description
            }) {
                let dbPost = PostData(context: self.context)
                dbPost.title = post.title
                dbPost.postDescription = post.description
                dbPost.author = post.author
                dbPost.image = post.image
                dbPost.likes = Int16(post.likes)
                dbPost.views = Int32(post.views)
            }
        case .remove(let post):
            self.context.delete(post)
        }
        do {
            try self.context.save()
        } catch {
            print("🔴\(error)")
        }
    }
}
