//
//  MainViewModel.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import FirebaseAuth
import Foundation

class MainViewModel: ObservableObject {
  @Published var currentUserId: String = ""
  private var handler: AuthStateDidChangeListenerHandle?

  init() {
    self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      self?.currentUserId = user?.uid ?? ""
    }
  }

  public var isSignedIn: Bool {
    return Auth.auth().currentUser != nil
  }
} 