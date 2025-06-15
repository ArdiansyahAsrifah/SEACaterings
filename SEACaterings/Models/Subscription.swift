//
//  Subscription.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import Foundation
import SwiftUI

struct Subscription: Codable, Identifiable {
    let id = UUID()
    var planName: String
    var price: Double
    var duration: String
    var isActive: Bool
    var startDate: Date
    var endDate: Date
}
