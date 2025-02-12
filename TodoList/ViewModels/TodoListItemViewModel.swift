//
//  TodoListItemViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation

class TodoListItemViewModel: ObservableObject {
    @Published var todo: Todo
    private let parentViewModel: TodoListViewModel
    
    init(todo: Todo, parentViewModel: TodoListViewModel) {
        self.todo = todo
        self.parentViewModel = parentViewModel
    }
    
    func toggleTodoCompletion() {
        // Toggle local state immediately for better UX
        todo.isDone.toggle()
        
        // Update in Firebase through parent
        parentViewModel.toggleTodoCompletion(todo)
    }
}
