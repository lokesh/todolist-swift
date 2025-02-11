//
//  ProfileView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = Auth.auth().currentUser {
                    // User info section
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.blue)
                        
                        Text(user.email ?? "No email")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 32)
                    
                    Spacer()
                    
                    // Logout button
                    TLButton(
                        title: "Log Out",
                        background: .red
                    ) {
                        viewModel.signOut()
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
