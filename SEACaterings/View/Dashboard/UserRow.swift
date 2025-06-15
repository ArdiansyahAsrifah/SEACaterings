//
//  UserRow.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(user.fullName)
                    .font(.headline)
                
                Spacer()
                
                Text(user.role.displayName)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(user.role == .admin ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
            
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Subscriptions: \(user.subscriptions.count)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}
