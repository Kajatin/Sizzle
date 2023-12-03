//
//  RecipeDetail.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe
    @Binding var navigationPath: [Recipe]

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
                        RecipeEditorSheet(recipe: recipe, navigationPath: $navigationPath)
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
                HStack(alignment: .center, spacing: 10) {
                    Text("\(recipe.name)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    Button {
                        recipe.favorite.toggle()
                    } label: {
                        Group {
                            if recipe.favorite {
                                Image(systemName: "star")
                            } else {
                                Image(systemName: "star.fill")
                            }
                        }
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    }
                }

                RecipeParameters(recipe: recipe)
            }

            Spacer()

            Button {

            } label: {
                Label("Add to Schedule", systemImage: "list.clipboard")
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
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
                Divider()
                RecipeStats(recipe: recipe)
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
        if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 240)
                .clipped()
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
                .scaleEffect(0.25)
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
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.headline.smallCaps())
                .padding(.bottom, 4)

            ForEach(ingredients) { ingredient in
                IngredientRow(ingredient: ingredient)
            }

            Button {

            } label: {
                Label("Add to Shopping List", systemImage: "cart")
            }
            .padding(.top, 10)
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

struct RecipeStats: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {


            if (recipe.cookedCount > 0) {
                Text("Cooked \(recipe.cookedCount) time\(recipe.cookedCount == 1 ? "" : "s")")
                    .foregroundStyle(.secondary)
            }

            if let lastPrepared = recipe.lastPrepared {
                Text("Last prepared \(lastPrepared.formatted(date: .long, time: .shortened))")
                    .foregroundStyle(.secondary)
            }

            Button {
                recipe.cookedCount += 1
                recipe.lastPrepared = .now
            } label: {
                Label("Log Cook", systemImage: "frying.pan")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
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
    @State var path: [Recipe] = []
    let recipe = Recipe.example()
    recipe.cuisineType = .spanish
    recipe.mealType = .lunch
    return RecipeDetail(recipe: recipe, navigationPath: $path)
}
