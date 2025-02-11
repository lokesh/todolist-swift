//
//  RegisterView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Registration Form
                    VStack(spacing: 20) {
                        Text("Create an account")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                        
                        VStack(spacing: 0) {
                            TextField("Your Name", text: $name)
                                .textInputAutocapitalization(.words)
                                .padding()
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                            
                            Divider()
                            
                            TextField("Email", text: $email)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding()
                            
                            Divider()
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        
                        TLButton(
                            title: "Create account",
                            action: {
                                // Registration action will go here
                            }
                        )
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
