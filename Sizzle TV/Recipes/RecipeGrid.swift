//
//  RecipeGrid.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 07/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct RecipeGrid: View {
    @Binding var navigationPath: [Recipe]

    @Query(sort: \Recipe.name) private var recipes: [Recipe]

    var body: some View {
        if recipes.isEmpty {
            Text("Get started by adding some recipes")
                .font(.title3)
                .padding(30)
                .background(.thinMaterial)
                .clipped()
                .cornerRadius(20)
        } else {
            ScrollView {
                VStack(spacing: 30) {
                    HSection(title: "Recently Added", recipes: Array(recipes.filter { $0.created > .now.addingTimeInterval(-2_592_000) }.prefix(10)))
                    
                    HSection(title: "Up Next", recipes: recipes.filter { $0.schedule ?? .now > .now })
                    
                    HSection(title: "Favorites", recipes: recipes.filter { $0.favorite })
                    
                    HSection(title: "Dinner", recipes: recipes.filter { $0.mealType == .dinner })
                    
                    HSection(title: "Breakfast", recipes: recipes.filter { $0.mealType == .breakfast })
                    
                    HSection(title: "Dessert", recipes: recipes.filter { $0.mealType == .dessert })
                    
                    HSection(title: "Drink", recipes: recipes.filter { $0.mealType == .drink })
                    
                    HSection(title: "Quick & Easy", recipes: recipes.filter { $0.difficulty == .easy })
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Browse")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: 50) {
                                ForEach(recipes) { recipe in
                                    NavigationLink(value: recipe) {
                                        RecipeTile(recipe: recipe)
                                    }
                                    .buttonStyle(
                                        RecipeTileButtonStyle()
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .scenePadding()
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        }
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
                            .buttonStyle(
                                RecipeTileButtonStyle()
                            )
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
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .tint(.secondary)
                        .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50)
//                    AsyncImage(url: URL(string: "https://spanishsabores.com/wp-content/uploads/2023/07/Tortilla-de-Patatas-Featured.jpg")) { p in
//                        switch p {
//                        case .success(let image):
//                            image.resizable().renderingMode(.original)
//                        default:
//                            ProgressView()
//                        }
//                    }
                }
            }
            .aspectRatio(4/3, contentMode: .fill)
            .frame(width: 300, height: 225)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            Text(recipe.name)
                .font(.footnote.bold())
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(width: 300)
        }
    }
}

struct RecipeTileButtonStyle: PrimitiveButtonStyle {
    @FocusState private var isFocused: Bool
    
    func makeBody(configuration: CardButtonStyle.Configuration) -> some View {
        configuration.label
            .focusable()
            .focused($isFocused)
            .onTapGesture {
                configuration.trigger()
            }
            .scaleEffect(isFocused ? 1.07 : 1)
            .shadow(color: isFocused ? .black.opacity(0.3) : .clear, radius: 20, x: 0, y: 10)
            .animation(.easeInOut(duration: 0.1), value: isFocused)
    }
}

#Preview {
    @State var path: [Recipe] = []
    return RecipeGrid(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}

