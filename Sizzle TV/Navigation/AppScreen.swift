//
//  AppScreen.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case foryou
    case recipes
    case upnext
    case search
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .foryou:
            Label("For You", systemImage: "person")
                .labelStyle(.titleOnly)
        case .recipes:
            Label("Recipes", systemImage: "book.pages")
                .labelStyle(.titleOnly)
        case .upnext:
            Label("Up Next", systemImage: "sun.max")
                .labelStyle(.titleOnly)
        case .search:
//            Label("Search", systemImage: "magnifyingglass")
//                .labelStyle(.iconOnly)
            Image(systemName: "magnifyingglass")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .foryou:
            ForYouNavigationStack()
        case .recipes:
            RecipeNavigationStack()
        case .upnext:
            UpNextNavigationStack()
        case .search:
            SearchNavigationStack()
        }
    }
}


