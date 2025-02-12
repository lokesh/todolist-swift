//
//  TodoListItemView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct TodoListItemView: View {
    let todo: Todo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(todo.title)
                .font(.headline)
            Text("Due: \(todo.dueDateObject.formatted())")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    // Create a sample todo for the preview
    TodoListItemView(todo: Todo(
        id: "1",
        title: "Sample Todo",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: false,
        userId: "user1"
    ))
}
