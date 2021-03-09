//
//  Todo.swift
//  TodoApp
//
//  Created by 中川祥平 on 2021/03/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Todo: Identifiable, Codable {
    let id: String
    let text: String
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
    
    init(text: String) {
        self.id = UUID().uuidString
        self.text = text
    }
}
