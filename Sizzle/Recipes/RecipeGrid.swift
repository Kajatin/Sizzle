//
//  RecipeGrid.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct RecipeGrid: View {
    @Binding var navigationPath: [Recipe]
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.created) private var recipes: [Recipe]
    
    @State private var searchText = ""
    var searchResults: [Recipe] {
        if searchText.isEmpty {
            return recipes
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
                }
            }
        }
        .scenePadding()
        .navigationTitle("Recipes")
        .navigationDestination(for: Recipe.self) { recipe in
            EmojiBackground()
                .overlay {
                    RecipeDetail(recipe: recipe, navigationPath: $navigationPath)
                }
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
        .searchable(text: $searchText, prompt: "Find a recipe")
    }
}

struct RecipeTile: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Group {
                if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .tint(.secondary)
                        .frame(minWidth: 50, maxWidth: 70, minHeight: 50, maxHeight: 70)
                }
            }
            .aspectRatio(4/3, contentMode: .fit)
            .frame(width: 320, height: 240)
            .background(.regularMaterial)
            .overlay(alignment: .bottom) {
                Text(recipe.name)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    @State var path: [Recipe] = []
    return RecipeGrid(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
