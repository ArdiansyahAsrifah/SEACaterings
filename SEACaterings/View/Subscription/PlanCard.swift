//
//  PlanCard.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct PlanCard: View {
    let plan: SubscriptionFormView.Plan
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                
                Image(systemName: plan.icon)
                    .font(.title2)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [plan.color, plan.color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40)
                
            
                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.rawValue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(plan.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
               
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Rp\(Int(plan.pricePerMeal).formattedWithSeparator())")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("per meal")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
               
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(plan.color)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? plan.color.opacity(0.1) : Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? plan.color : Color.clear, lineWidth: 2)
                    )
            )
        }
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

