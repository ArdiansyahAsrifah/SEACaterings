//
//  MainAppView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct MainAppView: View {
    @ObservedObject var authManager: AuthenticationManager
    @State private var selectedTab = 0
    @StateObject private var navigationVM = NavigationViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(authManager: authManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                .tag(0)
            
            MealPlansView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Meal Plan")
                }
                .tag(1)
            
            SubscriptionFormView()
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Subscriptions")
                }
                .tag(2)
            
            if authManager.isAdmin() {
                AdminView(authManager: authManager)
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Admin")
                    }
                    .tag(3)
            }
            
            ProfileView(authManager: authManager)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
    }
}
