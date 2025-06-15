//
//  MealPlanCard.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct MealPlanCard: View {
    let plan: MealPlan
    let index: Int
    let onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                
                ZStack(alignment: .topTrailing) {
                    if let imageName = plan.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 140)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 140)
                    }
                    
                    if plan.isPopular {
                        Text("🔥 Popular")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color.red.opacity(0.8))
                            )
                            .padding(8)
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(plan.name)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", plan.rating))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(plan.category)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                        )
                    
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(plan.price)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        if let originalPrice = plan.originalPrice {
                            Text(originalPrice)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                                .strikethrough()
                        }
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.orange)
                            Text(plan.calories)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Image(systemName: "fork.knife")
                                .font(.system(size: 12))
                                .foregroundColor(.green)
                            Text(plan.servings)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(plan.description)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Spacer()
                        Text("View Details")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient(
                            colors: [Color.blue, Color.purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .padding(.top, 4)
                }
                .padding(16)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(
            color: Color.blue.opacity(0.2),
            radius: isPressed ? 5 : 8,
            x: 0,
            y: isPressed ? 2 : 4
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}
