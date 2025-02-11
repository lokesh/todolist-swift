//
//  User.swift
//  TodoList
//
//  Created by Lokesh Dhakar on 2/11/25.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}

