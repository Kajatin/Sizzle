//
//  RecipeGrid.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import SwiftData

struct RecipeGrid: View {
    @Binding var navigationPath: [Recipe]
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.created) private var recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))]) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeTile(recipe: recipe)
                    }
                }
            }
        }
        .navigationTitle("Recipes")
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetail(recipe: recipe)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    withAnimation {
                        let newRecipe = Recipe.example()
                        modelContext.insert(newRecipe)
                        navigationPath.append(newRecipe)
                    }
                } label: {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
}

struct RecipeTile: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.secondary.gradient)
                .frame(width: 240, height: 240)
            Text(recipe.name)
                .lineLimit(2, reservesSpace: true)
                .font(.headline)
        }
        .tint(.primary)
    }
}

#Preview {
    @State var path: [Recipe] = []
    return RecipeGrid(navigationPath: $path)
        .modelContainer(for: Recipe.self, inMemory: true)
}
