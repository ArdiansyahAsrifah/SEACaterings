//
//  NavigationItem.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import Foundation

enum NavigationItem: String, CaseIterable, Identifiable {
    case home = "Home"
    case menu = "Menu"
    case subscription = "Subscription"
    case contact = "Contact Us"
    
    var id: String { self.rawValue }
}
