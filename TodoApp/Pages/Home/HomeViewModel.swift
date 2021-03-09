//
//  HomeViewModel.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import Combine

final class HomeViewModel: ObservableObject {
    
    @Published private(set) var items: [Todo] = []
    
    private let firestoreRepository: FirestoreRepository
    
    init(firestoreRepository: FirestoreRepository = FirestoreRepositoryImpl()) {
        self.firestoreRepository = firestoreRepository
    }
    
    func onDelete(index: Int) {
        let documentPath = items[index].documentPath
        firestoreRepository.delete(documentPath: documentPath) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error { print(error); return; }
            self.items.remove(at: index)
            print("success")
        }
    }
}

