//
//  RatingSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct RatingSelector: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { star in
                Button(action: {
                    rating = star
                }) {
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundStyle(
                            star <= rating ?
                            LinearGradient(
                                colors: [Color.yellow, Color.orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ) :
                            LinearGradient(colors: [Color.gray.opacity(0.4)], startPoint: .leading, endPoint: .trailing)
                        )
                }
                .scaleEffect(star <= rating ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: rating)
            }
        }
    }
}
