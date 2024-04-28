//
//  ContentView.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct ContentView: View {
    @State private var selection: AppScreen? = .recipes
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
//            NavigationSplitView {
//                AppSidebarList(selection: $selection)
//            } detail: {
//                AppDetailColumn(screen: selection)
//            }
            
            NavigationStack {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

#Preview {
    ContentView()
        .recipeDataContainer(inMemory: true)
}
