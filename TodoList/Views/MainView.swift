//
//  ContentView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
            TabView {
                TodoListView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
