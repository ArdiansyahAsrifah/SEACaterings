//
//  PriceSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

// MARK: - Price Summary Section
struct PriceSummarySection: View {
    let selectedPlan: SubscriptionFormView.Plan
    let mealCount: Int
    let dayCount: Int
    let totalPrice: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Price Summary", icon: "dollarsign.circle.fill", color: .green)
            
            VStack(spacing: 12) {
                PriceRow(title: "Selected Plan", value: selectedPlan.rawValue, isHighlighted: false)
                PriceRow(title: "Price per meal", value: "Rp\(Int(selectedPlan.pricePerMeal).formattedWithSeparator())", isHighlighted: false)
                PriceRow(title: "Meals per day", value: "\(mealCount)", isHighlighted: false)
                PriceRow(title: "Delivery days", value: "\(dayCount)", isHighlighted: false)
                PriceRow(title: "Monthly meals", value: "\(Int(Double(mealCount * dayCount) * 4.3))", isHighlighted: false)
                
                Divider()
                
                PriceRow(title: "Total Monthly Price", value: "Rp\(Int(totalPrice).formattedWithSeparator())", isHighlighted: true)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [.green.opacity(0.3), .blue.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Price Row
struct PriceRow: View {
    let title: String
    let value: String
    let isHighlighted: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(isHighlighted ? .headline : .body)
                .fontWeight(isHighlighted ? .bold : .medium)
                .foregroundColor(isHighlighted ? .primary : .secondary)
            
            Spacer()
            
            Text(value)
                .font(isHighlighted ? .headline : .body)
                .fontWeight(isHighlighted ? .bold : .semibold)
                .foregroundStyle(
                    isHighlighted ?
                    LinearGradient(
                        colors: [.green, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    ) :
                    LinearGradient(colors: [.primary], startPoint: .leading, endPoint: .trailing)
                )
        }
        .padding(.vertical, isHighlighted ? 4 : 2)
    }
}
