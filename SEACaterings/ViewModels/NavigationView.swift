//
//  NavigationView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var selectedTab: NavigationItem = .home
}
