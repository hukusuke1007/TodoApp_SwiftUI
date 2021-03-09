//
//  FormViewModel.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import Foundation

final class FormViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published private(set) var createdAt: String = ""
    @Published private(set) var loading: Bool = false

    var disable: Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private let documentRepository: DocumentRepository
    private let firebaseAuthRepository: FirebaseAuthRepository
    private let documentId: String?
    
    init(
        documentRepository: DocumentRepository = DocumentRepositoryImpl(),
        firebaseAuthRepository: FirebaseAuthRepository = FirebaseAuthRepositoryImpl(),
        todo: Todo?
    ) {
        self.documentRepository = documentRepository
        self.firebaseAuthRepository = firebaseAuthRepository
        if let data = todo {
            documentId = data.id
            self.text = data.text
            self.createdAt = data.dateLabel
        } else {
            documentId = nil
        }
    }
    
    func onSave(completion: ((Error?) -> Void)? = nil) {
        loading = true
        let userId = firebaseAuthRepository.userId!
        let docId = documentRepository.fetchDocId(Todo.collectionPath(userId: userId))
        let item = Todo(id: documentId ?? docId, text: text)
        if (documentId != nil) {
            documentRepository.update(data: item.data(), documentPath: item.documentPath(userId: userId), completion: { [weak self] error in
                self?.loading = false
                completion?(error)
            })
        } else {
            documentRepository.save(data: item, documentPath: item.documentPath(userId: userId), completion: { [weak self] error in
                self?.loading = false
                completion?(error)
            })
        }
    }
}

