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
    
    var body: some View {
        ScrollView {
            VStack {
                RecipeHeaderView(recipe: recipe)
                
                Divider()
                
                RecipeInfoView(recipe: recipe)
                
                Divider()
                
                IngredientsView(ingredients: recipe.ingredients)
                
                Divider()
                
                InstructionsView(instructions: recipe.instructions)
            }
        }
        .navigationTitle(recipe.name)
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

struct RecipeHeaderView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            // Placeholder for image
            Rectangle()
                .fill(Color.secondary)
                .aspectRatio(16/9, contentMode: .fit)
            
            Text(recipe.summary)
                .font(.subheadline)
                .padding()
        }
    }
}

struct RecipeInfoView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            DetailView(title: "Prep Time", value: "\(recipe.prepTime) min")
            Spacer()
            DetailView(title: "Cook Time", value: "\(recipe.cookingTime) min")
            Spacer()
            DetailView(title: "Serves", value: "\(recipe.servingSize)")
        }
        .padding()
    }
}

struct DetailView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
            Text(value)
                .font(.title2)
        }
    }
}

struct IngredientsView: View {
    var ingredients: [Ingredient]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.headline)
                .padding(.leading)
            ForEach(ingredients) { ingredient in
                Text("\(ingredient.quantity, specifier: "%.2f") \(ingredient.unit) \(ingredient.name)")
                    .padding(.leading)
            }
        }
    }
}

struct InstructionsView: View {
    var instructions: [Instruction]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.headline)
                .padding(.leading)
            ForEach(instructions) { instruction in
                VStack(alignment: .leading) {
                    Text(instruction.title)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    Text(instruction.instruction)
                        .padding(.leading)
                }
            }
        }
    }
}


#Preview {
    let recipe = Recipe()
    return RecipeDetail(recipe: recipe)
}
