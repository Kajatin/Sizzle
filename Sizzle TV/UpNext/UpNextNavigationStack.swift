//
//  UpNextNavigationStack.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct UpNextNavigationStack: View {
    @State private var path: [Recipe] = []
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack(path: $path) {
            UpNext(navigationPath: $path)
        }
        .onAppear {
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
            modelContext.insert(Recipe.example())
        }
    }
}

#Preview {
    UpNextNavigationStack()
        .recipeDataContainer(inMemory: true)
}
