//
//  CollectionRepository.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

protocol CollectionRepository: class {
    var hasMore: Bool { get }
    func fetchListener<T: Decodable>(collectionPath: String, limit: Int?, completion: (([T]?, Error?) -> Void)?)
    func dispose()
}

final class CollectionRepositoryImpl<T: Decodable>: CollectionRepository {
    
    var hasMore: Bool = false
    
    private let db: Firestore
    private var _data: [Decodable] = []
    private var _disposer: ListenerRegistration?
    
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
    
    func fetchListener<T: Decodable>(collectionPath: String, limit: Int?, completion: (([T]?, Error?) -> Void)? = nil) {
        var _query = db.collection(collectionPath).order(by: "createdAt", descending: true)
        if let limit = limit {
            _query = _query.limit(to: limit)
        }
        if _disposer != nil {
            dispose()
            self._data.removeAll()
        }
        _disposer = _query.addSnapshotListener { [weak self] (snapshot, error) in
            do {
                guard let self = self, let snapshot = snapshot else { completion?(nil, nil); return; }
                if let error = error { completion?(nil, error); return;}
                for change in snapshot.documentChanges {
                    if (change.type == DocumentChangeType.removed) {
                        /// 削除
                        self._data.remove(at: Int(change.oldIndex))
                    } else {
                        if let doc = try change.document.data(as: T.self) {
                            if (change.type == DocumentChangeType.added) {
                                /// 追加
                                self._data.insert(doc, at: Int(change.newIndex))
                            } else if (change.type == DocumentChangeType.modified) {
                                /// 更新
                                if (change.oldIndex == change.newIndex) {
                                    self._data[Int(change.newIndex)] = doc
                                } else {
                                    self._data.remove(at: Int(change.oldIndex))
                                    self._data.insert(doc, at: Int(change.newIndex))
                                }
                            }
                        }
                    }
                }
                self.hasMore = limit != nil ? self._data.count >= limit! : false
                completion?(self._data as? Array<T>, nil)
            } catch let error {
                completion?(nil, error)
            }
        }
    }
    
    func dispose() {
        _disposer?.remove()
        _disposer = nil
    }
}

