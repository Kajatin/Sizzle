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
    
    var body: some View {
        NavigationStack(path: $path) {
            UpNext(navigationPath: $path)
        }
    }
}

#Preview {
    UpNextNavigationStack()
        .recipeDataContainer(inMemory: true)
}
