//
//  TodoListApp.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI
import FirebaseCore

@main
struct TodoListApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
