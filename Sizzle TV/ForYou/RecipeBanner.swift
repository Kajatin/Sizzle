//
//  RecipeBanner.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import RecipeDataContainer
import SwiftData

struct RecipeBanner: View {
    @Bindable var recipe: Recipe
    @Binding var navigationPath: [Recipe]

    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .renderingMode(.original)
                } else {
                    Color.pastelBackground
//                    AsyncImage(url: URL(string: "https://spanishsabores.com/wp-content/uploads/2023/07/Tortilla-de-Patatas-Featured.jpg")) { p in
//                        switch p {
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .renderingMode(.original)
//                        default:
//                            ProgressView()
//                        }
//                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(recipe.name)")
                        .font(.title)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button {
                        navigationPath.append(recipe)
                    } label: {
                        Text("View Recipe")
                    }
                    .focused($isFocused)
                }
                
                RecipeParameters(recipe: recipe)
                
                Text("\(recipe.summary)")
                    .font(.headline)
                    .padding(.top)
                    .lineLimit(2)
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 65)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.65), Color.black.opacity(0.85)]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isFocused = true
            }
        }
    }
}

#Preview {
    do {
        @State var path: [Recipe] = []
        let schema = Schema([
            Recipe.self,
        ])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        
        let recipe = Recipe.example()
        recipe.cuisineType = .spanish
        recipe.mealType = .lunch
        return NavigationStack {
            RecipeBanner(recipe: recipe, navigationPath: $path)
                .modelContainer(container)
        }
    } catch {
        fatalError("Failed to create model context.")
    }
}
