//
//  PlanSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

// MARK: - Plan Selection Section
struct PlanSelectionSection: View {
    @Binding var selectedPlan: SubscriptionFormView.Plan
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Choose Your Plan", icon: "star.circle.fill", color: .orange)
            
            VStack(spacing: 12) {
                ForEach(SubscriptionFormView.Plan.allCases) { plan in
                    PlanCard(plan: plan, isSelected: selectedPlan == plan) {
                        selectedPlan = plan
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}
