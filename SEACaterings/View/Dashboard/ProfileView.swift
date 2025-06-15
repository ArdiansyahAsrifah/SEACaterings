//
//  ProfileView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = authManager.currentUser {

                    VStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.orange)
                        
                        Text(user.fullName)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(user.email)
                            .foregroundColor(.secondary)
                        
                        Text(user.role.displayName)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(user.role == .admin ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Divider()
                    

                    VStack(alignment: .leading, spacing: 15) {
                        InfoRow(label: "Member Since", value: user.createdAt.formatted(date: .abbreviated, time: .omitted))
                        InfoRow(label: "Total Subscriptions", value: "\(user.subscriptions.count)")
                        InfoRow(label: "Active Subscriptions", value: "\(user.subscriptions.filter { $0.isActive }.count)")
                    }
                    
                    Spacer()
                    

                    Button("Logout") {
                        authManager.logout()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}
