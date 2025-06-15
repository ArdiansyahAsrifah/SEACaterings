//
//  HeaderView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct HeaderView: View {
    @StateObject private var viewModel = HeaderViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.42, blue: 0.42),
                    Color(red: 0.93, green: 0.35, blue: 0.14)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: CGFloat.random(in: 60...120))
                    .position(
                        x: CGFloat.random(in: 50...300),
                        y: CGFloat.random(in: 50...150)
                    )
                    .animation(
                        .easeInOut(duration: Double.random(in: 3...6))
                        .repeatForever(autoreverses: true),
                        value: viewModel.logoRotation
                    )
            }
            
            VStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    Text("🍽️")
                        .font(.system(size: 36))
                        .rotationEffect(.degrees(viewModel.logoRotation))
                }
                
                Text("SEA Catering")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                
                Text("Healthy Meals, Anytime, Anywhere")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 60)
            .padding(.bottom, 40)
        }
        .frame(height: 280)
        .onAppear {
            viewModel.startAnimation()
        }
    }
}
