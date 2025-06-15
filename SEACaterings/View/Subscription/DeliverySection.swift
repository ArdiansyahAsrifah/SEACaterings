//
//  DeliverySection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct DeliveryDaysSection: View {
    @Binding var deliveryDays: Set<String>
    let allDays: [String]
    let isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Delivery Days", icon: "calendar.circle.fill", color: .green)
            
            VStack(spacing: 8) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                    ForEach(allDays, id: \.self) { day in
                        DayCard(
                            day: day,
                            isSelected: deliveryDays.contains(day)
                        ) {
                            if deliveryDays.contains(day) {
                                deliveryDays.remove(day)
                            } else {
                                deliveryDays.insert(day)
                            }
                        }
                    }
                }
                
                if !isValid {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text("Please select at least one delivery day")
                            .font(.caption)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    .padding(.top, 5)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}
