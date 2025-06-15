//
//  AdminView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct AdminView: View {
    @ObservedObject var authManager: AuthenticationManager
    @State private var newName = ""
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var showAddUserSheet = false
    @State private var showDeleteAlert = false
    @State private var userToDelete: User?
    @State private var addUserSuccess = false
    @State private var searchText = ""
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return authManager.users
        } else {
            return authManager.users.filter { user in
                user.fullName.localizedCaseInsensitiveContains(searchText) ||
                user.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Admin Dashboard")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                    
                                    Text("Manage users and system settings")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                
                                VStack(alignment: .trailing) {
                                    Text("\(authManager.users.count)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                    
                                    Text("Total Users")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(UIColor.systemBackground))
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                        
                        
                        
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            
                            TextField("Search users...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(UIColor.systemBackground))
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                        
                        
                        LazyVStack(spacing: 12) {
                            ForEach(filteredUsers) { user in
                                UserCard(user: user) {
                                    userToDelete = user
                                    showDeleteAlert = true
                                }
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing).combined(with: .opacity),
                                    removal: .move(edge: .leading).combined(with: .opacity)
                                ))
                            }
                        }
                        .padding(.horizontal)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: filteredUsers.count)
                        
                        if filteredUsers.isEmpty {
                            EmptyStateView(searchText: searchText)
                                .padding()
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showAddUserSheet) {
            AddUserSheet(
                authManager: authManager,
                newName: $newName,
                newEmail: $newEmail,
                newPassword: $newPassword,
                addUserSuccess: $addUserSuccess
            )
        }
        .alert("Delete User", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let user = userToDelete {
                    withAnimation(.spring()) {
                        authManager.deleteUser(user)
                    }
                }
            }
        } message: {
            Text("Are you sure you want to delete this user? This action cannot be undone.")
        }
        .alert("Success!", isPresented: $addUserSuccess) {
            Button("OK") { }
        } message: {
            Text("User has been added successfully.")
        }
    }
}

// MARK: - User Card Component
struct UserCard: View {
    let user: User
    let onDelete: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .overlay(
                    Text(String(user.fullName.prefix(1)).uppercased())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            // User Info
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                    Text("Active")
                        .font(.caption)
                        .foregroundColor(.green)
                        .fontWeight(.medium)
                }
            }
            
            Spacer()
            
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            // Handle tap if needed
        }
    }
}

// MARK: - Add User Sheet
struct AddUserSheet: View {
    @ObservedObject var authManager: AuthenticationManager
    @Binding var newName: String
    @Binding var newEmail: String
    @Binding var newPassword: String
    @Binding var addUserSuccess: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        Text("Add New User")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Enter user details below")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Form
                    VStack(spacing: 16) {
                        CardTextField(
                            title: "Full Name",
                            text: $newName,
                            icon: "person.fill"
                        )
                        
                        CardTextField(
                            title: "Email",
                            text: $newEmail,
                            icon: "envelope.fill"
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        
                        CustomSecureField(
                            title: "Password",
                            text: $newPassword,
                            icon: "lock.fill"
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: addUser) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add User")
                                        .fontWeight(.semibold)
                                }
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                        }
                        .disabled(isLoading || newName.isEmpty || newEmail.isEmpty || newPassword.isEmpty)
                        .opacity((newName.isEmpty || newEmail.isEmpty || newPassword.isEmpty) ? 0.6 : 1.0)
                        
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
    
    private func addUser() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let result = authManager.addUser(fullName: newName, email: newEmail, password: newPassword)
            
            isLoading = false
            
            if result.0 {
                newName = ""
                newEmail = ""
                newPassword = ""
                addUserSuccess = true
                dismiss()
            }
        }
    }
}



// MARK: - Custom Secure Field
struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                SecureField(title, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
        }
    }
}

// MARK: - Empty State View
struct EmptyStateView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: searchText.isEmpty ? "person.3" : "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text(searchText.isEmpty ? "No Users Yet" : "No Results Found")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(searchText.isEmpty ? "Start by adding your first user" : "Try adjusting your search")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
}

// MARK: - Scale Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Custom Text Field
struct CardTextField: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                TextField(title, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
        }
    }
}
