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
                ForEach(recipes.shuffled().prefix(10)) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeBanner(recipe: recipe, navigationPath: $navigationPath)
                    }
                    .buttonStyle(
                        ForYouTileButtonStyle()
                    )
                }
            }
            .tabViewStyle(.page)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        } else {
            Text("For You works better if you add recipes")
                .font(.title3)
                .padding(30)
                .background(.thinMaterial)
                .clipped()
                .cornerRadius(20)
        }
    }
}

struct ForYouTileButtonStyle: PrimitiveButtonStyle {
    @FocusState private var isFocused: Bool
    
    func makeBody(configuration: CardButtonStyle.Configuration) -> some View {
        configuration.label
    }
}

#Preview {
    @State var path: [Recipe] = []
    
    return ForYouCarousel(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
