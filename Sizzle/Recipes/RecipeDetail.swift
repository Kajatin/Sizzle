//
//  RecipeDetail.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe
    
    @State private var showEditSheet = false
    
    let spacing: CGFloat = 20 // Define the spacing
    
    var body: some View {
        ZStack {
            EmojiBackground()
                .overlay {
                    VStack {
                        RecipeHeader(recipe: recipe)
                        
                        GeometryReader { geometry in
                            HStack(alignment: .top, spacing: spacing) {
                                Column1(recipe: recipe)
                                    .frame(width: (geometry.size.width - spacing) * 2 / 5)
                                Column2(recipe: recipe)
                                    .frame(width: (geometry.size.width - spacing) * 3 / 5)
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("\(recipe.name)")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showEditSheet = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                        }
                    }
                    .sheet(isPresented: $showEditSheet) {
                        RecipeEditorSheet(recipe: recipe)
                    }
                }
        }
    }
}

struct RecipeHeader: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(recipe.name)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                RecipeParameters(recipe: recipe)
            }
            
            Spacer()
            
            Controls()
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct Controls: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Label("Add to Shopping List", systemImage: "cart")
            }
        }
    }
}

struct Column1: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                RecipeImage(recipe: recipe)
                RecipeInfo(recipe: recipe)
                Divider()
                RecipeIngredients(ingredients: recipe.ingredients)
            }
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct Column2: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            InstructionsView(instructions: recipe.instructions)
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct RecipeImage: View {
    let recipe: Recipe
    
    var body: some View {
        AsyncImage(url: URL(string: "https://images.kitchenstories.io/wagtailOriginalImages/R2457-photo-title-1.jpg")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                Color.blue // Acts as a placeholder.
            }
        }
    }
}

struct RecipeInfo: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                RecipeInfoUnit(title: "Prep Time", value: "\(recipe.prepTime) min")
                Spacer()
                Divider()
                Spacer()
                RecipeInfoUnit(title: "Cook Time", value: "\(recipe.cookingTime) min")
                Spacer()
                Divider()
                Spacer()
                RecipeInfoUnit(title: "Serves", value: "\(recipe.servingSize)")
            }
            .padding()
            .fixedSize(horizontal: false, vertical: true)
            
            Divider()
            
            Text(recipe.summary)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct RecipeInfoUnit: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline.smallCaps())
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
        }
    }
}

struct RecipeIngredients: View {
    var ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            Text("Ingredients")
                .font(.headline.smallCaps())
                .padding(.bottom, 4)
            
            ForEach(ingredients) { ingredient in
                IngredientRow(ingredient: ingredient)
            }
        }
        .padding()
    }
}

struct IngredientRow: View {
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(ingredient.name)
            Spacer()
            Text("\(ingredient.quantity, specifier: "%.0f") \(ingredient.unit)")
        }
        .padding(.vertical, 2)
        Divider()
    }
}

struct InstructionsView: View {
    var instructions: [Instruction]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.headline.smallCaps())
                .padding(.bottom, 4)
            
            ForEach(instructions.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Step \(index + 1)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        let instruction = instructions[index]
                        Text(instruction.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(instruction.instruction)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Divider()
                        .padding(.bottom, 12)
                }
            }
        }
        .padding()
    }
}

struct RecipeParameters: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 14) {
            RecipeParametersUnit(image: "chart.bar", value: "\(recipe.difficulty.rawValue)")
            Divider()
            RecipeParametersUnit(image: "fork.knife", value: "\(recipe.cuisineType.rawValue)")
            Divider()
            RecipeParametersUnit(image: "clock", value: "\(recipe.mealType.rawValue)")
        }
        .fixedSize(horizontal: false, vertical: true)
        .foregroundStyle(.secondary)
    }
}

struct RecipeParametersUnit: View {
    var image: String
    var value: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: image)
                .font(.subheadline.smallCaps())
            Text(value)
                .font(.headline)
        }
    }
}

#Preview {
    let recipe = Recipe.example()
    recipe.cuisineType = .spanish
    recipe.mealType = .lunch
    return RecipeDetail(recipe: recipe)
}
