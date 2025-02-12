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
    @State private var showingError = false
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: NewTodoViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Todo title", text: $viewModel.title)
                DatePicker("Due Date", 
                          selection: $viewModel.dueDate,
                          in: Date()...,
                          displayedComponents: [.date])
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
                        viewModel.save { success in
                            if success {
                                dismiss()
                            } else {
                                showingError = true
                            }
                        }
                    }
                    .disabled(viewModel.title.isEmpty)
                }
            }
            .alert("Error", isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    NewTodoView(userId: "")
}
