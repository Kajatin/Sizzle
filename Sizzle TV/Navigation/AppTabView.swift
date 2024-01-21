//
//  AppTabView.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import RecipeDataContainer

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.recipes))
        .recipeDataContainer(inMemory: true)
}
