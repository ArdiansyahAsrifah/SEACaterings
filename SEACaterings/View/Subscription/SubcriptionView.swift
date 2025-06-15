//
//  SubcriptionView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct SubscriptionFormView: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var showSuccessAlert = false
    
    enum Plan: String, CaseIterable, Identifiable {
        case diet = "Diet Plan"
        case protein = "Protein Plan"
        case royal = "Royal Plan"
        
        var id: String { rawValue }
        var pricePerMeal: Double {
            switch self {
            case .diet: return 24.00
            case .protein: return 15.00
            case .royal: return 18.00
            }
        }
        
        var description: String {
            switch self {
            case .diet: return "Healthy & Light"
            case .protein: return "High Protein"
            case .royal: return "Premium Quality"
            }
        }
        
        var color: Color {
            switch self {
            case .diet: return .green
            case .protein: return .orange
            case .royal: return .purple
            }
        }
        
        var icon: String {
            switch self {
            case .diet: return "leaf.fill"
            case .protein: return "flame.fill"
            case .royal: return "crown.fill"
            }
        }
    }
    
    @State private var selectedPlan: Plan = .diet
    

    @State private var mealTypes: Set<String> = []
    let allMealTypes = ["Breakfast", "Lunch", "Dinner"]
    
    
    @State private var deliveryDays: Set<String> = []
    let allDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @State private var allergies: String = ""
    
    
    var isValidName: Bool { !name.trimmingCharacters(in: .whitespaces).isEmpty }
    var isValidPhone: Bool { phoneNumber.trimmingCharacters(in: .whitespaces).count >= 10 }
    var isValidMealTypes: Bool { !mealTypes.isEmpty }
    var isValidDeliveryDays: Bool { !deliveryDays.isEmpty }
    
    var canSubmit: Bool {
        isValidName && isValidPhone && isValidMealTypes && isValidDeliveryDays
    }
    
    
    var totalPrice: Double {
        let planPrice = selectedPlan.pricePerMeal
        let mealsCount = Double(mealTypes.count)
        let daysCount = Double(deliveryDays.count)
        return planPrice * mealsCount * daysCount * 4.3
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                
                HeaderSection()
                
                VStack(spacing: 20) {
                    
                    PersonalInfoSection(name: $name, phoneNumber: $phoneNumber)
                    
                    PlanSelectionSection(selectedPlan: $selectedPlan)
                    
                    MealTypesSection(mealTypes: $mealTypes, allMealTypes: allMealTypes, isValid: isValidMealTypes)
                    
                    DeliveryDaysSection(deliveryDays: $deliveryDays, allDays: allDays, isValid: isValidDeliveryDays)
                    
                    AllergiesSection(allergies: $allergies)
                    
                    PriceSummarySection(
                        selectedPlan: selectedPlan,
                        mealCount: mealTypes.count,
                        dayCount: deliveryDays.count,
                        totalPrice: totalPrice
                    )
                    
                    SubmitButton(canSubmit: canSubmit) {
                        submitForm()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .padding(.top, 60)
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.large)
        .alert("Success!", isPresented: $showSuccessAlert) {
            Button("OK") { }
        } message: {
            Text("Your subscription has been submitted successfully!")
        }
    }
    
    func submitForm() {
        print("Submitting subscription form")
        print("Name:", name)
        print("Phone:", phoneNumber)
        print("Plan:", selectedPlan.rawValue)
        print("Meals:", mealTypes)
        print("Days:", deliveryDays)
        print("Allergies:", allergies)
        print("Total Price:", totalPrice)
        
        showSuccessAlert = true
        
        name = ""
        phoneNumber = ""
        selectedPlan = .diet
        mealTypes.removeAll()
        deliveryDays.removeAll()
        allergies = ""
    }
}

// MARK: - Supporting Views

struct SectionHeader: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(
                    LinearGradient(
                        colors: [color, color.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let icon: String
    let color: Color
    let isRequired: Bool
    var keyboardType: UIKeyboardType = .default
    var isMultiLine: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                if isRequired {
                    Text("*")
                        .foregroundColor(.red)
                }
            }
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 20)
                
                if isMultiLine {
                    TextField("Optional", text: $text, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .keyboardType(keyboardType)
                } else {
                    TextField("", text: $text)
                        .keyboardType(keyboardType)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }
}

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

#Preview {
    NavigationView {
        SubscriptionFormView()
    }
}
