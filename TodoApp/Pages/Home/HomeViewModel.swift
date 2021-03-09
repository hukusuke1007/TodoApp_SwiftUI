//
//  HomeViewModel.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var items: [Todo] = []
    
    private let documentRepository: DocumentRepository
    private let collectionRepository: CollectionRepository
    private let firebaseAuthRepository: FirebaseAuthRepository
    
    private let limit: Int = 10
    private var pagingLimit: Int = 10
    private let collectionPath: String
    
    init(
        documentRepository: DocumentRepository = DocumentRepositoryImpl(),
        collectionRepository: CollectionRepository = CollectionRepositoryImpl<Todo>(),
        firebaseAuthRepository: FirebaseAuthRepository = FirebaseAuthRepositoryImpl()
    ) {
        self.documentRepository = documentRepository
        self.collectionRepository = collectionRepository
        self.firebaseAuthRepository = firebaseAuthRepository
        let userId = firebaseAuthRepository.userId!
        self.collectionPath = Todo.collectionPath(userId: userId)
        collectionRepository.fetchListener(collectionPath: self.collectionPath, limit: limit) { [weak self] (docs: [Todo]?, error) in
            guard let self = self else { return }
            if let error = error { print(error); return; }
            if let docs = docs {
                self.items = docs
            }
        }
    }
    
    deinit {
        collectionRepository.dispose()
    }
    
    func onDelete(index: Int) {
        let userId = firebaseAuthRepository.userId!
        let documentPath = items[index].documentPath(userId: userId)
        documentRepository.delete(documentPath: documentPath) { (error) in
            if let error = error { print(error); return; }
            print("success")
        }
    }
    
    func onLoadMore() {
        let hasMore = collectionRepository.hasMore
        print("onLoadMore hasMore: \(hasMore)")
        if (!hasMore) {
            return
        }
        self.pagingLimit += self.limit
        collectionRepository.fetchListener(collectionPath: self.collectionPath, limit: pagingLimit) { [weak self] (docs: [Todo]?, error) in
            guard let self = self else { return }
            if let error = error { print(error); return; }
            if let docs = docs {
                self.items = docs
            }
        }
    }
}

