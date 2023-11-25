//
//  AppScreen.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case recipes
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .recipes:
            Label("Recipes", systemImage: "bird")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .recipes:
            RecipeNavigationStack()
        }
    }
}

