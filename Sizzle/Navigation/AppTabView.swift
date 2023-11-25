//
//  AppTabView.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

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
        .modelContainer(for: Recipe.self, inMemory: true)
}
