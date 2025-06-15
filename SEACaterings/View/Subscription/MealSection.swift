//
//  MealSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct MealTypesSection: View {
    @Binding var mealTypes: Set<String>
    let allMealTypes: [String]
    let isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Meal Types", icon: "clock.circle.fill", color: .purple)
            
            VStack(spacing: 10) {
                ForEach(allMealTypes, id: \.self) { meal in
                    MealTypeCard(
                        title: meal,
                        isSelected: mealTypes.contains(meal),
                        icon: mealIcon(for: meal),
                        color: mealColor(for: meal)
                    ) {
                        if mealTypes.contains(meal) {
                            mealTypes.remove(meal)
                        } else {
                            mealTypes.insert(meal)
                        }
                    }
                }
                
                if !isValid {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text("Please select at least one meal type")
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
    
    func mealIcon(for meal: String) -> String {
        switch meal {
        case "Breakfast": return "sun.rise.fill"
        case "Lunch": return "sun.max.fill"
        case "Dinner": return "moon.stars.fill"
        default: return "fork.knife"
        }
    }
    
    func mealColor(for meal: String) -> Color {
        switch meal {
        case "Breakfast": return .orange
        case "Lunch": return .yellow
        case "Dinner": return .indigo
        default: return .gray
        }
    }
}
