//
//  TodoListView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct TodoListView: View {
    @StateObject var viewModel = TodoListViewModel()
    @State private var showingNewTodoSheet = false

    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    var body: some View {
        NavigationStack {
            List(viewModel.todos) { todo in
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .font(.headline)
                    Text("Due: \(todo.dueDateObject.formatted())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewTodoSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewTodoSheet) {
                NewTodoView(userId: userId)
            }
            .onAppear {
                viewModel.fetchTodos(for: userId)
            }
        }
    }
}

#Preview {
    TodoListView(userId: "")
}
