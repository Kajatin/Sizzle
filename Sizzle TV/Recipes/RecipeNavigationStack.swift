//
//  RecipeNavigationStack.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct RecipeNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            RecipeGrid(navigationPath: $path)
        }
    }
}

#Preview {
    RecipeNavigationStack()
        .recipeDataContainer(inMemory: true)
}
