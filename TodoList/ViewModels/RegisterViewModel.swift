//
//  RegisterViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func register() {
        if validate() {
            // Try to create user with Firebase
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    // Handle error
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                // Get user ID and insert user record
                guard let userId = result?.user.uid else {
                    self.errorMessage = "Could not create user record"
                    return
                }
                
                self.insertUserRecord(id: userId)
                
                // Success - user is registered and logged in
                self.errorMessage = ""
                // Note: Navigation will be handled by a state change listener
            }
        }
    }
    
    private func insertUserRecord(id: String) {
        // Create a new user with current timestamp
        let newUser = User(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        
        // Create document reference
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) { [weak self] error in
                if let error = error {
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
    }

    func validate() -> Bool {
        // Reset error state
        errorMessage = ""
        
        // Name validation
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter your name"
            return false
        }
        
        // Email validation
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter an email"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        // Password validation
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter a password"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters"
            return false
        }
        
        return true
    }
}
