//
//  ForYouNavigationStack.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct ForYouNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ForYouCarousel(navigationPath: $path)
        }
        .onDisappear {
            path.removeAll()
        }
    }
}

#Preview {
    ForYouNavigationStack()
        .recipeDataContainer(inMemory: true)
}
