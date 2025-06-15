//
//  MealPlanDetailView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct MealPlanDetailView: View {
    let plan: MealPlan
    @Environment(\.dismiss) var dismiss
    @State private var showFullDescription = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    
                    ZStack(alignment: .bottomLeading) {
                        if let imageName = plan.imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipped()
                        } else {
                            Rectangle()
                                .fill(LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(height: 300)
                        }
                        
                        LinearGradient(
                            colors: [Color.clear, Color.black.opacity(0.7)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            if plan.isPopular {
                                Text("🔥 Most Popular")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Capsule().fill(Color.red.opacity(0.8)))
                            }
                            
                            Text(plan.name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            HStack {
                                HStack(spacing: 4) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < Int(plan.rating) ? "star.fill" : "star")
                                            .font(.system(size: 14))
                                            .foregroundColor(.yellow)
                                    }
                                    Text(String(format: "%.1f", plan.rating))
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                Text(plan.category)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Capsule().fill(Color.white.opacity(0.2)))
                            }
                        }
                        .padding(20)
                    }
                    
                    
                    VStack(spacing: 25) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(alignment: .bottom, spacing: 8) {
                                    Text(plan.price)
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.primary)
                                    
                                    if let originalPrice = plan.originalPrice {
                                        Text(originalPrice)
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.secondary)
                                            .strikethrough()
                                    }
                                }
                                Text("per week")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                        }
                        
                        Divider()
                        
                        HStack(spacing: 30) {
                            VStack(spacing: 4) {
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.orange)
                                Text(plan.calories)
                                    .font(.system(size: 14, weight: .semibold))
                                Text("Calories")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(spacing: 4) {
                                Image(systemName: "fork.knife")
                                    .font(.system(size: 20))
                                    .foregroundColor(.green)
                                Text(plan.servings)
                                    .font(.system(size: 14, weight: .semibold))
                                Text("Servings")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(spacing: 4) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                                Text("7 days")
                                    .font(.system(size: 14, weight: .semibold))
                                Text("Duration")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("About This Plan")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(plan.description)
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                                .lineLimit(showFullDescription ? nil : 3)
                            
                            if plan.description.count > 100 {
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        showFullDescription.toggle()
                                    }
                                }) {
                                    Text(showFullDescription ? "Show Less" : "Show More")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .padding(20)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
