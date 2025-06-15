//
//  MenuView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct MealPlansView: View {
    @State private var selectedPlan: MealPlan?
    @State private var showingDetails = false
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var animatedCards: [Bool] = Array(repeating: false, count: 4)
    
    let categories = ["All", "Balanced", "Fitness", "Plant-Based", "Low-Carb"]

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredPlans: [MealPlan] {
        let filtered = selectedCategory == "All" ? MealPlan.samplePlans : MealPlan.samplePlans.filter { $0.category == selectedCategory }
        return searchText.isEmpty ? filtered : filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            ForEach(0..<8, id: \.self) { i in
                Circle()
                    .fill(Color.blue.opacity(0.05))
                    .frame(width: CGFloat.random(in: 30...60))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 4...8))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...3)),
                        value: animatedCards[0]
                    )
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {

                    VStack(spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("🍽️ Meal Plans")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.blue, Color.purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                
                                Text("Choose your perfect dining experience")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search meal plans...", text: $searchText)
                                .foregroundColor(.black)
                                .accentColor(.blue)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                            selectedCategory = category
                                        }
                                    }) {
                                        Text(category)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(selectedCategory == category ? .white : .blue)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(selectedCategory == category ?
                                                          LinearGradient(
                                                            colors: [Color.blue, Color.purple],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                          ) :
                                                          LinearGradient(
                                                            colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                          ))
                                            )
                                            .scaleEffect(selectedCategory == category ? 1.05 : 1.0)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 20)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(filteredPlans.enumerated()), id: \.element.id) { index, plan in
                            MealPlanCard(plan: plan, index: index) {
                                selectedPlan = plan
                                showingDetails = true
                            }
                            .scaleEffect(animatedCards.indices.contains(index) ? (animatedCards[index] ? 1.0 : 0.8) : 1.0)
                            .opacity(animatedCards.indices.contains(index) ? (animatedCards[index] ? 1.0 : 0.0) : 1.0)
                            .onAppear {
                                if animatedCards.indices.contains(index) {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(Double(index) * 0.1)) {
                                        animatedCards[index] = true
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .sheet(isPresented: $showingDetails) {
            if let plan = selectedPlan {
                MealPlanDetailView(plan: plan)
            }
        }
        .onAppear {
            animatedCards = Array(repeating: false, count: MealPlan.samplePlans.count)
        }
    }
}


struct MealPlansView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlansView()
            .preferredColorScheme(.dark)
    }
}
