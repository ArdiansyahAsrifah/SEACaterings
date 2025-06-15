//
//  PersonalInfoSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct PersonalInfoSection: View {
    @Binding var name: String
    @Binding var phoneNumber: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "Personal Information", icon: "person.circle.fill", color: .blue)
            
            VStack(spacing: 12) {
                CustomTextField(
                    title: "Full Name",
                    text: $name,
                    icon: "person.fill",
                    color: .blue,
                    isRequired: true
                )
                
                CustomTextField(
                    title: "Phone Number",
                    text: $phoneNumber,
                    icon: "phone.fill",
                    color: .green,
                    isRequired: true,
                    keyboardType: .phonePad
                )
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}
