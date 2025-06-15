//
//  FeatureViewModel.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

class FeaturesViewModel: ObservableObject {
    @Published var features: [Feature] = [
        Feature(icon: "🎯", title: "Kustomisasi Menu", description: "Sesuaikan menu makanan dengan preferensi dan kebutuhan diet Anda", colors: [Color(red: 0.45, green: 0.73, blue: 1.0), Color(red: 0.04, green: 0.52, blue: 0.89)]),
        Feature(icon: "🚚", title: "Pengiriman Nasional", description: "Layanan pengiriman ke kota-kota besar di seluruh Indonesia", colors: [Color(red: 0.99, green: 0.48, blue: 0.66), Color(red: 0.91, green: 0.26, blue: 0.58)]),
        Feature(icon: "📊", title: "Informasi Nutrisi Lengkap", description: "Detail informasi kandungan gizi untuk setiap menu makanan", colors: [Color(red: 0.99, green: 0.80, blue: 0.43), Color(red: 0.88, green: 0.44, blue: 0.33)])
    ]
    
    @Published var animateWelcome = false
    @Published var animateFeatures = false
}
