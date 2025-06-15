//
//  Feature.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct Feature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let colors: [Color]
}
