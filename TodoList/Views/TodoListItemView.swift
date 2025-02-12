//
//  TodoListItemView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct TodoListItemView: View {
    @StateObject private var viewModel: TodoListItemViewModel
    
    init(todo: Todo, parentViewModel: TodoListViewModel) {
        _viewModel = StateObject(wrappedValue: TodoListItemViewModel(todo: todo, parentViewModel: parentViewModel))
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .strokeBorder(viewModel.todo.isDone ? Color.gray : Color.blue, lineWidth: 2)
                .background(
                    Circle()
                        .fill(viewModel.todo.isDone ? Color.gray : Color.clear)
                )
                .frame(width: 24, height: 24)
                .onTapGesture {
                    viewModel.toggleTodoCompletion()
                }
            
            VStack(alignment: .leading) {
                Text(viewModel.todo.title)
                    .font(.headline)
                    .foregroundColor(viewModel.todo.isDone ? .gray : .primary)
                Text("Due: \(viewModel.todo.dueDateObject.formatted())")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    // Create a sample todo for the preview
    TodoListItemView(
        todo: Todo(
            id: "1",
            title: "Sample Todo",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            userId: "user1"
        ),
        parentViewModel: TodoListViewModel()
    )
}
