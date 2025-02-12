//
//  NewTodoViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation
import FirebaseFirestore

class NewTodoViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var errorMessage: String = ""
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func save() {
        if validate() {
            let db = Firestore.firestore()
            
            // Create todo item
            let newTodo = [
                "title": title,
                "dueDate": dueDate.timeIntervalSince1970,
                "createdDate": Date().timeIntervalSince1970,
                "isDone": false,
                "userId": userId
            ] as [String : Any]
            
            // Save to Firestore
            db.collection("todos").addDocument(data: newTodo) { [weak self] error in
                if let error = error {
                    self?.errorMessage = "Failed to save todo: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter a title"
            return false
        }
        
        guard dueDate >= Date() else {
            errorMessage = "Due date must be in the future"
            return false
        }
        
        return true
    }
}
