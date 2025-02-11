//
//  RegisterView.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
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
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                        }
                        
                        VStack(spacing: 0) {
                            TextField("Your Name", text: $viewModel.name)
                                .textInputAutocapitalization(.words)
                                .padding()
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                            
                            Divider()
                            
                            TextField("Email", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding()
                            
                            Divider()
                            
                            SecureField("Password", text: $viewModel.password)
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
                                viewModel.register()
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
