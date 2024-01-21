//
//  ForYouCarousel.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct ForYouCarousel: View {
    @Binding var navigationPath: [Recipe]
    
    @Query(sort: \Recipe.created) private var recipes: [Recipe]
    
    var body: some View {
        if !recipes.isEmpty {
            TabView {
                ForEach(recipes) { recipe in
                    RecipeBanner(recipe: recipe)
                }
            }
            .tabViewStyle(.page)
        } else {
            ProgressView()
        }
    }
}

#Preview {
    @State var path: [Recipe] = []
    
    return ForYouCarousel(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
