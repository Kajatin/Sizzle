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
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    
    @State private var searchText = ""
    var searchResults: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                if searchText.isEmpty {
                    HSection(title: "Recently Added", recipes: Array(recipes.filter { $0.created > .now.addingTimeInterval(-30 * 24 * 60 * 60) }.prefix(10)))
                    
                    HSection(title: "Up Next", recipes: recipes.filter { $0.schedule ?? .now > .now })
                    
                    HSection(title: "Favorites", recipes: recipes.filter { $0.favorite })
                    
                    HSection(title: "Dinner", recipes: recipes.filter { $0.mealType == .dinner })
                    
                    HSection(title: "Breakfast", recipes: recipes.filter { $0.mealType == .breakfast })
                    
                    HSection(title: "Dessert", recipes: recipes.filter { $0.mealType == .dessert })
                    
                    HSection(title: "Drink", recipes: recipes.filter { $0.mealType == .drink })
                    
                    HSection(title: "Quick & Easy", recipes: recipes.filter { $0.difficulty == .easy && ($0.prepTime + $0.cookingTime) < 90 })
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Browse")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 30) {
                            ForEach(searchResults) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeTile(recipe: recipe)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .scenePadding()
        .navigationTitle("Recipes")
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetail(recipe: recipe, navigationPath: $navigationPath)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    withAnimation {
                        let newRecipe = Recipe()
                        modelContext.insert(newRecipe)
                        navigationPath.append(newRecipe)
                    }
                } label: {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
        .searchable(text: $searchText, prompt: "Find a recipe")
//        .onAppear {
//            modelContext.insert(Recipe.example())
//            modelContext.insert(Recipe.example())
//            modelContext.insert(Recipe.example())
//            modelContext.insert(Recipe.example())
//        }
    }
}

struct HSection: View {
    var title: String
    var recipes: [Recipe]
    
    var body: some View {
        if !recipes.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 30) {
                        ForEach(recipes) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeTile(recipe: recipe)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct RecipeTile: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "book.pages")
                        .resizable()
                        .scaledToFit()
                        .tint(.secondary)
                        .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50)
//                    AsyncImage(url: URL(string: "https://spanishsabores.com/wp-content/uploads/2023/07/Tortilla-de-Patatas-Featured.jpg")) { p in
//                        switch p {
//                        case .success(let image):
//                            image.resizable().renderingMode(.original)
//                                .scaledToFill()
//                        default:
//                            ProgressView()
//                        }
//                    }
                }
            }
            .aspectRatio(4/3, contentMode: .fill)
            .frame(width: 200, height: 150)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(recipe.name)
                .font(.title3.bold())
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(width: 200)
        }
    }
}

#Preview {
    @State var path: [Recipe] = []
    return NavigationStack {
        RecipeGrid(navigationPath: $path)
            .recipeDataContainer(inMemory: true)
    }
}
