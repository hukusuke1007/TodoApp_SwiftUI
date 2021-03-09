//
//  FormViewModel.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import Combine

final class FormViewModel: ObservableObject {
    
    private let firestoreRepository: FirestoreRepository
    
    init(firestoreRepository: FirestoreRepository = FirestoreRepositoryImpl()) {
        self.firestoreRepository = firestoreRepository
    }
    
    func onSave(text: String) {
        let data = Todo(id: firestoreRepository.fetchDocId(Todo.collectionPath), text: text)
        firestoreRepository.save(data: data, documentPath: data.documentPath) { (error) in
            if let error = error { print(error); }
            // success
        }
    }
}

