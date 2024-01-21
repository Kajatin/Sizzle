//
//  SearchNavigationStack.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct SearchNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Search(navigationPath: $path)
        }
    }
}

#Preview {
    SearchNavigationStack()
        .recipeDataContainer(inMemory: true)
}
