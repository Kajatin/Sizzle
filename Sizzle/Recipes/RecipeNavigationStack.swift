//
//  RecipeNavigationStack.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
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
    NavigationStack {
        RecipeNavigationStack()
            .recipeDataContainer(inMemory: true)
    }
}
