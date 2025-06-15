//
//  DashboardView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var authManager: AuthenticationManager
    @StateObject private var featureVM = FeaturesViewModel()
    @StateObject private var navigationVM = NavigationViewModel()
    @StateObject private var testimonialVM = TestimonialViewModel()
    @State private var dateRange: ClosedRange<Date> = {
            let start = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
            return start...Date()
        }()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    ScrollView {
                        switch navigationVM.selectedTab {
                        case .home:
                            VStack(spacing: 0) {
                                HeaderView()
                                
                                Spacer()
                                
                                if let user = authManager.currentUser {
                                    VStack(spacing: 25) {
                                        VStack(spacing: 12) {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text("Welcome back! 👋")
                                                        .font(.subheadline)
                                                        .foregroundColor(.white.opacity(0.8))
                                                    
                                                    Text(user.fullName)
                                                        .font(.title)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                }
                                                
                                                Spacer()
                                            
                                                Circle()
                                                    .fill(
                                                        LinearGradient(
                                                            colors: [.white.opacity(0.3), .white.opacity(0.1)],
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                                    .frame(width: 50, height: 50)
                                                    .overlay(
                                                        Text(String(user.fullName.prefix(1)))
                                                            .font(.title2)
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.white)
                                                    )
                                                    .scaleEffect(1.0)
                                                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: UUID())
                                            }
                                            
                                            if user.role == .admin {
                                                VStack {
                                                    HStack {
                                                        Image(systemName: "crown.fill")
                                                            .foregroundColor(.yellow)
                                                            .font(.caption)
                                                        Text("Admin Dashboard")
                                                            .font(.headline)
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(.yellow)
                                                    }
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 16)
                                                    .background(
                                                        Capsule()
                                                            .fill(.ultraThinMaterial)
                                                            .overlay(
                                                                Capsule()
                                                                    .stroke(.yellow.opacity(0.5), lineWidth: 1)
                                                            )
                                                    )
                                                    .scaleEffect(1.0)
                                                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: UUID())
                                                    
                                                }
                                               
                                                
                                            }
                                        }
                                        .padding(24)
                                        .background(
                                            LinearGradient(
                                                colors: [
                                                    Color.purple.opacity(0.8),
                                                    Color.blue.opacity(0.8),
                                                    Color.cyan.opacity(0.6)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .cornerRadius(20)
                                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                                        
                                        
                                        if user.role == .admin {
                                            DatePicker("From", selection: Binding(get: {
                                                dateRange.lowerBound
                                            }, set: { newStart in
                                                dateRange = newStart...dateRange.upperBound
                                            }), displayedComponents: .date)
                                            
                                            DatePicker("To", selection: Binding(get: {
                                                dateRange.upperBound
                                            }, set: { newEnd in
                                                dateRange = dateRange.lowerBound...newEnd
                                            }), displayedComponents: .date)
                                            
                                            
                                            VStack(spacing: 15) {
                                                
                                                MetricCard.revenue(title: "New Subscriptions", value: "$45,000", change: "+8%", changeType: .positive)
                                                MetricCard.users(title: "Monthly Recurring Revenue (MRR)", value: "$15,000", change: "+15%", changeType: .negative)
                                                MetricCard.orders(title: "Reactivations", value: "5", change: "+15%", changeType: .neutral)
                                                MetricCard.crown(title: "Subscription Growth", value: "350 Active", change: "+15%", changeType: .positive)
                                                
                                            }
                                        }
                                        
                                        
                                        if user.role == .user {

                                            LazyVGrid(columns: [
                                                GridItem(.flexible(), spacing: 15),
                                                GridItem(.flexible(), spacing: 15)
                                            ], spacing: 20) {
                                                
                                                EnhancedDashboardCard(
                                                    title: "Active Subscriptions",
                                                    value: "\(user.subscriptions.filter { $0.isActive }.count)",
                                                    icon: "creditcard.fill",
                                                    gradientColors: [.green, .mint],
                                                    accentColor: .green,
                                                    shadowColor: .green.opacity(0.3)
                                                )
                                                

                                                EnhancedDashboardCard(
                                                    title: "Pause Subscriptions",
                                                    value: "\(user.subscriptions.count)",
                                                    icon: "list.bullet.rectangle.portrait.fill",
                                                    gradientColors: [.blue, .indigo],
                                                    accentColor: .blue,
                                                    shadowColor: .blue.opacity(0.3)
                                                )
                                                
                                                EnhancedDashboardCard(
                                                    title: "Monthly Spending",
                                                    value: "$299",
                                                    icon: "dollarsign.circle.fill",
                                                    gradientColors: [.orange, .red],
                                                    accentColor: .orange,
                                                    shadowColor: .orange.opacity(0.3)
                                                )
                                                
                                                EnhancedDashboardCard(
                                                    title: "Cancel Subscriptions",
                                                    value: "$89",
                                                    icon: "piggybank.fill",
                                                    gradientColors: [.pink, .purple],
                                                    accentColor: .pink,
                                                    shadowColor: .pink.opacity(0.3)
                                                )
                                            }
                                            
                                        }
                                       
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                }

                                
                                
                                VStack(spacing: 30) {
                                    WelcomeSection()
                                        .scaleEffect(featureVM.animateWelcome ? 1.0 : 0.8)
                                        .opacity(featureVM.animateWelcome ? 1.0 : 0.0)
                                        .animation(.easeOut(duration: 0.6).delay(0.2), value: featureVM.animateWelcome)
                                    
                                    FeaturesSection(features: featureVM.features)
                                        .offset(y: featureVM.animateFeatures ? 0 : 50)
                                        .opacity(featureVM.animateFeatures ? 1.0 : 0.0)
                                        .animation(.easeOut(duration: 0.6).delay(0.4), value: featureVM.animateFeatures)
                                    
                                    TestimonialSection()
                                        .environmentObject(testimonialVM)
                                        .padding(.top, 30)
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                .padding(.bottom, 50)
                            }
                            .onAppear {
                                featureVM.animateWelcome = true
                                featureVM.animateFeatures = true
                            }
                        case .menu:
                            MealPlansView()
                        case .subscription:
                            SubscriptionFormView()
                        case .contact:
                            ContactView()
                        }
                    }
                    .ignoresSafeArea(.container, edges: .top)
                    
                    if navigationVM.selectedTab == .home {
                        FloatingContactButton()
                    }
                    
                }
//                ResponsiveNavigationBar(viewModel: navigationVM)
            }
            .navigationBarHidden(true)
        }
    }
}

