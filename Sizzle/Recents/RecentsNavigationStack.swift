//
//  RecentsNavigationStack.swift
//  Sizzle
//
//  Created by Roland Kajatin on 03/12/2023.
//

import SwiftUI
import RecipeDataContainer

struct RecentsNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Recents(navigationPath: $path)
        }
    }
}

#Preview {
    RecentsNavigationStack()
        .recipeDataContainer(inMemory: true)
}
