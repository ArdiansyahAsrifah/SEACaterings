//
//  WelcomeSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct WelcomeSection: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.94, green: 0.58, blue: 0.98),
                            Color(red: 0.96, green: 0.34, blue: 0.42)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 100, height: 100)
                .offset(x: 120, y: -60)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(viewModel.welcomeTitle)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(viewModel.welcomeEmoji)
                        .font(.system(size: 24))
                    
                    Spacer()
                }
                
                Text(viewModel.welcomeMessage)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.95))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(30)
        }
    }
}
