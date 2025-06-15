//
//  ResponsiveNavigationBar.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct ResponsiveNavigationBar: View {
    @ObservedObject var viewModel: NavigationViewModel
    
    var body: some View {
        HStack {
            ForEach(NavigationItem.allCases) { item in
                Button(action: {
                    viewModel.selectedTab = item
                }) {
                    VStack {
                        Image(systemName: icon(for: item))
                        Text(item.rawValue)
                            .font(.caption2)
                    }
                    .foregroundColor(viewModel.selectedTab == item ? .white : .gray)
                    .padding(8)
                    .background(viewModel.selectedTab == item ? Color.accentColor : Color.clear)
                    .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
    
    func icon(for item: NavigationItem) -> String {
        switch item {
        case .home: return "house"
        case .menu: return "menucard"
        case .subscription: return "cart"
        case .contact: return "envelope"
        }
    }
}
