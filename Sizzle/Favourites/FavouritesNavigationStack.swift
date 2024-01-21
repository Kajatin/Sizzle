//
//  FavouritesNavigationStack.swift
//  Sizzle
//
//  Created by Roland Kajatin on 03/12/2023.
//

import SwiftUI
import RecipeDataContainer

struct FavouritesNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Favourites(navigationPath: $path)
        }
    }
}

#Preview {
    FavouritesNavigationStack()
        .recipeDataContainer(inMemory: true)
}
