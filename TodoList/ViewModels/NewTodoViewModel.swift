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
    
    func save(completion: @escaping (Bool) -> Void) {
        if validate() {
            let db = Firestore.firestore()
            
            // Create todo item using the Todo struct
            let todo = Todo(
                id: "", // Firestore will generate this
                title: title,
                dueDate: dueDate.timeIntervalSince1970,
                createdDate: Date().timeIntervalSince1970,
                isDone: false,
                userId: userId
            )
            
            // Convert Todo to dictionary for Firestore
            // We exclude 'id' since Firestore will generate it
            let todoDict: [String: Any] = [
                "title": todo.title,
                "dueDate": todo.dueDate,
                "createdDate": todo.createdDate,
                "isDone": todo.isDone,
                "userId": todo.userId
            ]
            
            // Save to Firestore
            db.collection("todos").addDocument(data: todoDict) { [weak self] error in
                if let error = error {
                    self?.errorMessage = "Failed to save todo: \(error.localizedDescription)"
                    completion(false)
                } else {
                    completion(true)
                }
            }
        } else {
            completion(false)
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter a title"
            return false
        }
        
        // Compare dates without time components
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let dueDateStart = calendar.startOfDay(for: dueDate)
        
        guard dueDateStart >= todayStart else {
            errorMessage = "Due date must be today or in the future"
            return false
        }
        
        return true
    }
}
