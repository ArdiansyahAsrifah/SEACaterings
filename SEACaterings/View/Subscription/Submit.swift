//
//  Submit.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI
// MARK: - Submit Button
struct SubmitButton: View {
    let canSubmit: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                
                Text("Submit Subscription")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                canSubmit ?
                LinearGradient(
                    colors: [.purple, .blue, .cyan],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ) :
                LinearGradient(colors: [Color.gray.opacity(0.5)], startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(
                color: canSubmit ? .purple.opacity(0.3) : .clear,
                radius: 8,
                x: 0,
                y: 4
            )
            .scaleEffect(canSubmit ? 1.0 : 0.98)
        }
        .disabled(!canSubmit)
        .animation(.easeInOut(duration: 0.2), value: canSubmit)
        .padding(.horizontal)
    }
}

