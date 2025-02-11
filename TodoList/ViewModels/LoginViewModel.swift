//
//  LoginViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login() {
        // Login implementation will go here
    }
}
