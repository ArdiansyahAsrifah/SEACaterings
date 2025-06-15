//
//  Authentication.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI
import CryptoKit
import Foundation


// MARK: - Security Manager
class SecurityManager {
    static let shared = SecurityManager()
    private init() {}
    
    func isPasswordValid(_ password: String) -> (isValid: Bool, message: String) {
        guard password.count >= 8 else {
            return (false, "Password must be at least 8 characters long")
        }
        
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        let hasSpecialChar = password.range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) != nil
        
        guard hasUppercase else {
            return (false, "Password must contain at least one uppercase letter")
        }
        guard hasLowercase else {
            return (false, "Password must contain at least one lowercase letter")
        }
        guard hasNumber else {
            return (false, "Password must contain at least one number")
        }
        guard hasSpecialChar else {
            return (false, "Password must contain at least one special character")
        }
        
        return (true, "Password is valid")
    }
    
    func hashPassword(_ password: String) -> String {
        let inputData = Data(password.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func verifyPassword(_ password: String, against hash: String) -> Bool {
        return hashPassword(password) == hash
    }
}

// MARK: - Authentication Manager
class AuthenticationManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    private let userDefaults = UserDefaults.standard
    private let usersKey = "stored_users"
    private let currentUserKey = "current_user"
    @Published var users: [User] = []

    
    init() {
        loadCurrentUser()
        self.users = getStoredUsers()
    }
    
    private func loadCurrentUser() {
        if let userData = userDefaults.data(forKey: currentUserKey),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    private func saveCurrentUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(users) {
            userDefaults.set(encoded, forKey: usersKey)
            self.users = users
        }
    }
    
    private func getStoredUsers() -> [User] {
        guard let data = userDefaults.data(forKey: usersKey),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        return users
    }
    
    private func saveUsers(_ users: [User]) {
        if let encoded = try? JSONEncoder().encode(users) {
            userDefaults.set(encoded, forKey: usersKey)
        }
    }
    
    func register(fullName: String, email: String, password: String, role: User.UserRole = .user) -> (success: Bool, message: String) {

        guard !fullName.isEmpty else {
            return (false, "Full name is required")
        }
        
        guard !email.isEmpty && email.contains("@") else {
            return (false, "Valid email is required")
        }
        
        let passwordValidation = SecurityManager.shared.isPasswordValid(password)
        guard passwordValidation.isValid else {
            return (false, passwordValidation.message)
        }
        
        var users = getStoredUsers()
        if users.contains(where: { $0.email.lowercased() == email.lowercased() }) {
            return (false, "Email already registered")
        }
        
        let hashedPassword = SecurityManager.shared.hashPassword(password)
        let newUser = User(
            fullName: fullName,
            email: email.lowercased(),
            passwordHash: hashedPassword,
            role: role,
            subscriptions: [],
            createdAt: Date()
        )
        
        users.append(newUser)
        saveUsers(users)
        
        return (true, "Registration successful")
    }
    
    func login(email: String, password: String) -> (success: Bool, message: String) {
        guard !email.isEmpty && !password.isEmpty else {
            return (false, "Email and password are required")
        }
        
        let users = getStoredUsers()
        
        if let user = users.first(where: { $0.email.lowercased() == email.lowercased() }) {
            if SecurityManager.shared.verifyPassword(password, against: user.passwordHash) {
                self.currentUser = user
                self.isAuthenticated = true
                saveCurrentUser(user)
                return (true, "Login successful")
            } else {
                return (false, "Invalid password")
            }
        } else {
            return (false, "User not found")
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.isAuthenticated = false
        userDefaults.removeObject(forKey: currentUserKey)
    }
    
    func isAdmin() -> Bool {
        return currentUser?.role == .admin
    }
    
    func getAllUsers() -> [User] {
        guard isAdmin() else { return [] }
        return getStoredUsers()
    }
    
    func addUser(fullName: String, email: String, password: String, role: User.UserRole = .user) -> (Bool, String) {
        return register(fullName: fullName, email: email, password: password, role: role)
    }

    func deleteUser(_ user: User) {
        var users = getStoredUsers()
        users.removeAll { $0.id == user.id }
        saveUsers(users)
    }

    func updateUser(_ updatedUser: User) {
        var users = getStoredUsers()
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
            saveUsers(users)
        }
    }

    func updateUserSubscription(_ subscription: Subscription) -> Bool {
        guard var user = currentUser else { return false }
        
        user.subscriptions.append(subscription)
        var users = getStoredUsers()
        
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
            saveUsers(users)
            self.currentUser = user
            saveCurrentUser(user)
            return true
        }
        
        return false
    }
}

#Preview {
    MainAppView(authManager: AuthenticationManager())
}


