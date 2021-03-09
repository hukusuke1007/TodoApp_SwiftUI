//
//  DocumentRepository.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

protocol DocumentRepository: class {
    func fetchDocId(_ path: String) -> String
    func save<T: Encodable>(data: T, documentPath: String, completion: ((Error?) -> Void)?)
    func update(data: [AnyHashable: Any], documentPath: String, completion: ((Error?) -> Void)?)
    func delete(documentPath: String, completion: ((Error?) -> Void)?)
    func fetch<T: Decodable>(documentPath: String, completion: ((T?, Error?) -> Void)?)
}

final class DocumentRepositoryImpl: DocumentRepository {
    
    private let db: Firestore
    
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
    
    func fetchDocId(_ path: String) -> String {
        return db.collection(path).document().documentID
    }
    
    func save<T: Encodable>(data: T, documentPath: String, completion: ((Error?) -> Void)? = nil) {
        do {
            try db.document(documentPath).setData(from: data, merge: true, completion: completion)
        } catch let error {
            completion?(error)
        }
    }
    
    func update(data: [AnyHashable: Any], documentPath: String, completion: ((Error?) -> Void)? = nil) {
        let updateData = data.merging(["updatedAt": FieldValue.serverTimestamp()]) { $1 }
        db.document(documentPath).updateData(updateData, completion: completion)
    }
    
    func delete(documentPath: String, completion: ((Error?) -> Void)? = nil) {
        db.document(documentPath).delete(completion: completion)
    }
    
    func fetch<T: Decodable>(documentPath: String, completion: ((T?, Error?) -> Void)? = nil) {
        db.document(documentPath).getDocument { (snapshot, error) in
            do {
                let data = try snapshot?.data(as: T.self)
                completion?(data, error)
            } catch let error {
                completion?(nil, error)
            }
        }
    }
    
    func fetchCollectionListener<T: Decodable>(collectionPath: String, completion: ((T?, Error?) -> Void)? = nil) -> ListenerRegistration  {
        return db.collection(collectionPath).addSnapshotListener { (snapshot, error) in

//            if let snapshot = snapshot {
//                for change in snapshot.documentChanges {
//                    if ()
//                }
//            }
        }
    }
}

