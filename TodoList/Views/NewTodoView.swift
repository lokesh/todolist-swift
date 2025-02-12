//
//  NewTodoView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct NewTodoView: View {
    @StateObject private var viewModel: NewTodoViewModel
    @Environment(\.dismiss) var dismiss
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: NewTodoViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                TextField("Todo title", text: $viewModel.title)
                DatePicker("Due Date", selection: $viewModel.dueDate )
                    .datePickerStyle(.graphical)
                
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        viewModel.save()
                        dismiss()
                    }
                    .disabled(viewModel.title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NewTodoView(userId: "")
}
