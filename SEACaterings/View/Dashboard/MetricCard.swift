//
//  MetricCard.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct MetricCard: View {
    let title: String
    let value: String
    var icon: String = "chart.bar.fill"
    var accentColor: Color = .blue
    var gradientColors: [Color] = [.blue, .cyan]
    var change: String? = nil
    var changeType: ChangeType = .neutral
    
    @State private var isAnimating = false
    @State private var showDetailView = false
    
    enum ChangeType {
        case positive, negative, neutral
        
        var color: Color {
            switch self {
            case .positive: return .green
            case .negative: return .red
            case .neutral: return .gray
            }
        }
        
        var icon: String {
            switch self {
            case .positive: return "arrow.up.right"
            case .negative: return "arrow.down.right"
            case .neutral: return "minus"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {

                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                        .shadow(color: accentColor.opacity(0.3), radius: 8, x: 0, y: 4)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                }
                
                Spacer()
                
                if let change = change {
                    HStack(spacing: 4) {
                        Image(systemName: changeType.icon)
                            .font(.caption)
                        Text(change)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(changeType.color)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(changeType.color.opacity(0.15))
                            .overlay(
                                Capsule()
                                    .stroke(changeType.color.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .contentTransition(.numericText())
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(accentColor.opacity(0.15))
                        .frame(height: 6)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: isAnimating ? geometry.size.width * 0.75 : 0, height: 6)
                        .animation(.easeInOut(duration: 1.5).delay(0.3), value: isAnimating)
                }
            }
            .frame(height: 6)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    accentColor.opacity(0.3),
                                    accentColor.opacity(0.1),
                                    .clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                )
        )
        .shadow(
            color: accentColor.opacity(0.2),
            radius: isAnimating ? 15 : 8,
            x: 0,
            y: isAnimating ? 8 : 4
        )
        .scaleEffect(showDetailView ? 1.02 : 1.0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: showDetailView)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                isAnimating = true
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                showDetailView.toggle()
            }
            
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    showDetailView = false
                }
            }
        }
    }
}

// MARK: - Usage Examples
struct MetricCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                
                // Basic Usage
                MetricCard(
                    title: "Total Revenue",
                    value: "$24,500"
                )
                
                // With Custom Icon and Colors
                MetricCard(
                    title: "New Customers",
                    value: "127",
                    icon: "person.badge.plus.fill",
                    accentColor: .green,
                    gradientColors: [.green, .mint],
                    change: "+15%",
                    changeType: .positive
                )
                
                // Negative Change Example
                MetricCard(
                    title: "Cancelled Orders",
                    value: "8",
                    icon: "xmark.circle.fill",
                    accentColor: .red,
                    gradientColors: [.red, .orange],
                    change: "-5%",
                    changeType: .negative
                )
                
                // Purple Theme
                MetricCard(
                    title: "Active Subscriptions",
                    value: "1,245",
                    icon: "crown.fill",
                    accentColor: .purple,
                    gradientColors: [.purple, .pink],
                    change: "+8%",
                    changeType: .positive
                )
            }
            .padding(20)
        }
        .background(Color.gray.opacity(0.1))
    }
}

// MARK: - Convenience Initializers
extension MetricCard {
    // Quick initializer for revenue metrics
    static func revenue(title: String, value: String, change: String? = nil, changeType: ChangeType = .neutral) -> MetricCard {
        return MetricCard(
            title: title,
            value: value,
            icon: "dollarsign.circle.fill",
            accentColor: .green,
            gradientColors: [.green, .mint],
            change: change,
            changeType: changeType
        )
    }
    
    // Quick initializer for user metrics
    static func users(title: String, value: String, change: String? = nil, changeType: ChangeType = .neutral) -> MetricCard {
        return MetricCard(
            title: title,
            value: value,
            icon: "person.3.fill",
            accentColor: .blue,
            gradientColors: [.blue, .cyan],
            change: change,
            changeType: changeType
        )
    }
    
    // Quick initializer for order metrics
    static func orders(title: String, value: String, change: String? = nil, changeType: ChangeType = .neutral) -> MetricCard {
        return MetricCard(
            title: title,
            value: value,
            icon: "cart.fill",
            accentColor: .orange,
            gradientColors: [.orange, .yellow],
            change: change,
            changeType: changeType
        )
    }
    
    // Quick initializer for order metrics
    static func crown(title: String, value: String, change: String? = nil, changeType: ChangeType = .neutral) -> MetricCard {
        return MetricCard(
            title: title,
            value: value,
            icon: "crown.fill",
            accentColor: .purple,
            gradientColors: [.purple, .pink],
            change: change,
            changeType: changeType
        )
    }
}
