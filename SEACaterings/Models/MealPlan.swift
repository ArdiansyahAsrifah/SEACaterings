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
    
}
