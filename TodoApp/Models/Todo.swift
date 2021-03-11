//
//  Todo.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Todo: Identifiable, Codable {
    /// Static
    static let collectionName: String = "todo"
    static func collectionPath(userId: String) -> String {
        return "personal/v1/user/\(userId)/\(Self.collectionName)"
    }
    static func documentPath(userId: String, docId: String) -> String {
        return "\(Self.collectionPath(userId: userId))/\(docId)"
    }
    
    /// FieldValue
    let text: String
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    
    /// Getter
    var dateLabel: String {
        if let data = createdAt {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = true
            // formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMMhms", options: 0, locale: Calendar.current.locale)
            return formatter.string(from: data.dateValue())
        }
        return "-"
    }
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    func data() -> [AnyHashable: Any] {
        return ["text": text]
    }
    
    func documentPath(userId: String) -> String {
        return "\(Self.collectionPath(userId: userId))/\(id!)"
    }
}
