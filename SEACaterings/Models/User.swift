//
//  User.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id = UUID()
    var fullName: String
    var email: String
    var passwordHash: String
    var role: UserRole
    var subscriptions: [Subscription]
    var createdAt: Date
    
    enum UserRole: String, Codable, CaseIterable {
        case user = "user"
        case admin = "admin"
        
        var displayName: String {
            switch self {
            case .user: return "User"
            case .admin: return "Admin"
            }
        }
    }
}
