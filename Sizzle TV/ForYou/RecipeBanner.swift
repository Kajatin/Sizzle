//
//  RecipeBanner.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import RecipeDataContainer

struct RecipeBanner: View {
    let recipe: Recipe

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.clear

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
//                            image.resizable().renderingMode(.original)
//                        default:
//                            ProgressView()
//                        }
//                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("\(recipe.name)")
                    .font(.title)
                RecipeParameters(recipe: recipe)
                Text("\(recipe.summary)")
                    .font(.headline)
                    .padding(.top)
//                Button {
//                    
//                } label: {
//                    Text("Go to Recipe")
//                        .fontWeight(.bold)
//                }
//                .padding(.top)
            }
            .frame(maxWidth: .infinity)
            .padding(40)
            .background(.thinMaterial)
        }
        .clipped()
        .cornerRadius(20)
        .focusable()
        .focused($isFocused)
        .onAppear {
            isFocused = true
        }
    }
}

//#Preview {
//    let recipe = Recipe.example()
//
//    return RecipeBanner(recipe: recipe)
//        .recipeDataContainer(inMemory: true)
//}
