//
//  LoginViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func login() {
        if validate() {
            // Try to sign in with Firebase
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    // Handle error - similar to catching errors in Vue/JS
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                // Success - user is logged in
                self.errorMessage = ""
                // Note: Navigation will be handled by a state change listener
            }
        }
    }

    func validate() -> Bool {
        // Reset error state
        errorMessage = ""
        
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
