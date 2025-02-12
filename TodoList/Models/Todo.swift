//
//  Todo.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    let userId: String
    
    // Computed property to get Date objects
    var dueDateObject: Date {
        return Date(timeIntervalSince1970: dueDate)
    }
    
    var createdDateObject: Date {
        return Date(timeIntervalSince1970: createdDate)
    }

    mutating func toggleDone() {
        isDone.toggle()
    }

    mutating func setDone(_ isDone: Bool) {
        self.isDone = isDone
    }
}
