//
//  UpNext.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct UpNext: View {
    @Binding var navigationPath: [Recipe]

    @Query var recipes: [Recipe]

    var body: some  View {
        ForEach(recipes.filter { $0.schedule ?? .now >= .now }) { recipe in
            Text(recipe.name)
        }
    }
}

#Preview {
    @State var path: [Recipe] = []

    return UpNext(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
