//
//  Testimonial.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import Foundation

struct Testimonial: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let rating: Int
}
