//
//  MealPlan.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI
import Foundation

// MARK: - Data Model
struct MealPlan: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let originalPrice: String?
    let description: String
    let imageName: String?
    let category: String
    let rating: Double
    let isPopular: Bool
    let calories: String
    let servings: String
    
    static let samplePlans: [MealPlan] = [
        MealPlan(name: "Healthy Pack", price: "$39.99", originalPrice: "$49.99", description: "A balanced diet plan for a healthy lifestyle including fresh veggies, lean protein, and whole grains. This plan helps improve digestion and maintain energy throughout the day.", imageName: "salad", category: "Balanced", rating: 4.8, isPopular: true, calories: "1800/day", servings: "3 meals"),
        MealPlan(name: "High Protein", price: "$49.99", originalPrice: nil, description: "Ideal for fitness enthusiasts. Includes chicken breast, eggs, legumes, and protein shakes to build and maintain muscle.", imageName: "chicken", category: "Fitness", rating: 4.9, isPopular: false, calories: "2200/day", servings: "4 meals"),
        MealPlan(name: "Vegan Delight", price: "$34.99", originalPrice: "$39.99", description: "100% plant-based meals. A delightful variety of fruits, grains, tofu, and nuts to keep you energized.", imageName: "vegan", category: "Plant-Based", rating: 4.7, isPopular: true, calories: "1600/day", servings: "3 meals"),
        MealPlan(name: "Keto Boost", price: "$44.99", originalPrice: nil, description: "Designed for those on a ketogenic diet. High in healthy fats and low in carbs.", imageName: "keto", category: "Low-Carb", rating: 4.6, isPopular: false, calories: "1900/day", servings: "3 meals")
    ]
    
}
