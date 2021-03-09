//
//  FormViewModel.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import Combine

final class FormViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published private(set) var createdAt: String = ""
    @Published private(set) var loading: Bool = false

    let isUpdate: Bool
    var disable: Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private let firestoreRepository: FirestoreRepository
    
    init(
        firestoreRepository: FirestoreRepository = FirestoreRepositoryImpl(),
        todo: Todo?
    ) {
        self.firestoreRepository = firestoreRepository
        if let data = todo {
            isUpdate = true
            self.text = data.text
            self.createdAt = data.dateLabel
        } else {
            isUpdate = false
        }
    }
    
    func onSave(completion: ((Error?) -> Void)? = nil) {
        loading = true
        let docId = firestoreRepository.fetchDocId(Todo.collectionPath)
        let data = Todo(id: docId, text: text)
        if (isUpdate) {
            firestoreRepository.update(data: data, documentPath: data.documentPath, completion: { [weak self] error in
                self?.loading = false
                completion?(error)
            })
        } else {
            firestoreRepository.save(data: data, documentPath: data.documentPath, completion: { [weak self] error in
                self?.loading = false
                completion?(error)
            })
        }
    }
}

