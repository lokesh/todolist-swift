//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation
import FirebaseFirestore

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    private let db = Firestore.firestore()
    
    func fetchTodos(for userId: String) {
        print("📝 Starting to fetch todos for user: \(userId)")
        
        db.collection("todos")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    print("❌ Error fetching todos: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("⚠️ No documents found in snapshot")
                    return
                }
                
                print("📥 Received \(documents.count) todo documents")
                
                self?.todos = documents.compactMap { document -> Todo? in
                    // Print raw document data for debugging
                    print("📄 Document \(document.documentID) raw data: \(document.data())")
                    
                    let data = document.data()
                    
                    // Manually create Todo object to better handle potential mismatches
                    guard let title = data["title"] as? String,
                          let dueDate = data["dueDate"] as? TimeInterval,
                          let createdDate = data["createdDate"] as? TimeInterval,
                          let isDone = data["isDone"] as? Bool,
                          let userId = data["userId"] as? String else {
                        print("❌ Missing or invalid fields in document \(document.documentID)")
                        print("Required fields:")
                        print("- title: \(data["title"] ?? "missing")")
                        print("- dueDate: \(data["dueDate"] ?? "missing")")
                        print("- createdDate: \(data["createdDate"] ?? "missing")")
                        print("- isDone: \(data["isDone"] ?? "missing")")
                        print("- userId: \(data["userId"] ?? "missing")")
                        return nil
                    }
                    
                    return Todo(
                        id: document.documentID,
                        title: title,
                        dueDate: dueDate,
                        createdDate: createdDate,
                        isDone: isDone,
                        userId: userId
                    )
                }
                
                print("✅ Successfully loaded \(self?.todos.count ?? 0) todos")
            }
    }
    
    func deleteTodo(_ todo: Todo) {
        print("🗑️ Attempting to delete todo: \(todo.id)")
        
        db.collection("todos").document(todo.id).delete { [weak self] error in
            if let error = error {
                print("❌ Error deleting todo: \(error.localizedDescription)")
                return
            }
            
            print("✅ Successfully deleted todo from Firestore")
            
            // Remove from local array
            DispatchQueue.main.async {
                self?.todos.removeAll { $0.id == todo.id }
            }
        }
    }
    
    func toggleTodoCompletion(_ todo: Todo) {
        let todoRef = db.collection("todos").document(todo.id)
        
        todoRef.updateData([
            "isDone": !todo.isDone,
            "dueDate": todo.dueDate,
            "createdDate": todo.createdDate
        ]) { [weak self] error in
            if let error = error {
                print("❌ Error updating todo: \(error.localizedDescription)")
                return
            }
            
            print("✅ Successfully updated todo completion status")
            
            // Update local array
            DispatchQueue.main.async {
                if let index = self?.todos.firstIndex(where: { $0.id == todo.id }) {
                    self?.todos[index].isDone.toggle()
                }
            }
        }
    }
}
