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
    
    @State private var searchText = ""
    
    var body: some View {
        SearchResult(navigationPath: $navigationPath, searchText: searchText)
        .searchable(text: $searchText, prompt: "Find a recipe")
    }
}

struct SearchResult: View {
    @Binding var navigationPath: [Recipe]
    
    @Query private var recipes: [Recipe]
    
    init(navigationPath: Binding<[Recipe]>, searchText: String) {
        _navigationPath = navigationPath
        _recipes = Query(filter: #Predicate {
            if searchText.isEmpty {
                return false
            } else {
                return $0.name.localizedStandardContains(searchText)
            }
        })
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 320))], spacing: 30) {
                ForEach(recipes) { recipe in
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
            RecipeDetail(recipe: recipe)
        }
    }
}

#Preview {
    @State var path: [Recipe] = []
    
    return Search(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
