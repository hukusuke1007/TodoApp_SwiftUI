//
//  Todo.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Todo: Identifiable, Codable {
    static let path: String = "todo"
    static let collectionPath: String = "personal/v1/\(Self.path)"
    static func documentPath(id: String) -> String {
        return "\(Self.collectionPath)/\(id)"
    }
    
    let text: String
    
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    
    var dateLabel: String {
        if let data = createdAt {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = true
            return formatter.string(from: data.dateValue())
        }
        return "-"
    }
    
    var documentPath: String {
        return Self.documentPath(id: id!)
    }
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    init(text: String) {
        self.id = UUID().uuidString
        self.text = text
    }
}
