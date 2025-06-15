//
//  HeaderViewModel.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI
import Combine

class HeaderViewModel: ObservableObject {
    @Published var logoRotation: Double = 0.0
    
    func startAnimation() {
        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
            logoRotation = 5
        }
    }
}
