//
//  AllergiesSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct AllergiesSection: View {
    @Binding var allergies: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Allergies & Dietary Restrictions", icon: "info.circle.fill", color: .red)
            
            CustomTextField(
                title: "Tell us about your allergies or dietary restrictions",
                text: $allergies,
                icon: "text.bubble.fill",
                color: .red,
                isRequired: false,
                isMultiLine: true
            )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}
