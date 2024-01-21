//
//  Search.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct Search: View {
    @Binding var navigationPath: [Recipe]
    
    @Query(sort: \Recipe.created) private var recipes: [Recipe]
    
    @State private var searchText = ""
    var searchResults: [Recipe] {
        if searchText.isEmpty {
            return []
        } else {
            return recipes.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 320))], spacing: 30) {
                ForEach(searchResults) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeTile(recipe: recipe)
                    }
                    .buttonStyle(
                        RecipeTileButtonStyle()
                    )
                }
            }
        }
        .navigationDestination(for: Recipe.self) { recipe in
            EmojiBackground()
                .overlay {
                    RecipeDetail(recipe: recipe)
                }
        }
        .searchable(text: $searchText, prompt: "Find a recipe")
    }
}

#Preview {
    @State var path: [Recipe] = []
    
    return Search(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
