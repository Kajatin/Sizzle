//
//  ContentView.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 07/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct ContentView: View {
    @State private var selection: AppScreen? = .recipes
    
    var body: some View {
        AppTabView(selection: $selection)
    }
}

#Preview {
    ContentView()
        .recipeDataContainer(inMemory: true)
}
