//
//  FeatureSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct FeaturesSection: View {
    let features: [Feature]
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Layanan Unggulan Kami")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
            
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                ForEach(features) { feature in
                    FeatureCard(feature: feature)
                }
            }
        }
    }
}
