//
//  FeatureCard.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct FeatureCard: View {
    let feature: Feature
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: feature.colors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.1), radius: isPressed ? 5 : 15, x: 0, y: isPressed ? 2 : 8)
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.1))
                .frame(width: 60, height: 120)
                .rotationEffect(.degrees(20))
                .offset(x: 110, y: -50)
            
            VStack(alignment: .leading, spacing: 15) {
                Text(feature.icon)
                    .font(.system(size: 36))
                    .scaleEffect(isPressed ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: isPressed)
                
                Text(feature.title)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(feature.description)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(25)
        }
        .frame(maxWidth: .infinity, minHeight: 160)
        .onTapGesture {
            withAnimation {
                isPressed.toggle()
            }
        }
    }
}

