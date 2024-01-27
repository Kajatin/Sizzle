//
//  RecipeDetail.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 14/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct RecipeDetail: View {
    let recipe: Recipe

    @State private var showEditSheet = false
    @State private var showScheduleSheet = false

    let spacing: CGFloat = 20

    var body: some View {
        EmojiBackground()
            .overlay {
                VStack {
                    HStack(alignment: .center) {
                        RecipeHeader(recipe: recipe)

                        Spacer()

                        HStack(alignment: .center) {
                            Button {
                                showScheduleSheet = true
                            } label: {
                                Label("Add to Schedule", systemImage: "list.clipboard")
                            }

                            Button {
                                showEditSheet = true
                            } label: {
                                Label("More", systemImage: "ellipsis")
                                    .labelStyle(.titleOnly)
                            }
                        }
                    }

                    GeometryReader { geometry in
                        HStack(alignment: .top, spacing: spacing) {
                            Column1(recipe: recipe)
                                .frame(width: (geometry.size.width - spacing) * 2 / 5)
                            Spacer()
                            Column2(recipe: recipe)
                                .frame(width: (geometry.size.width - spacing) * 3 / 5)
                        }
                    }
                }
            }
        .sheet(isPresented: $showEditSheet) {
            VStack {
                Button {
                    recipe.favorite.toggle()
                } label: {
                    Label(recipe.favorite ? "Remove from Favourites" : "Add to Favourites", systemImage: recipe.favorite ? "star.fill" : "star")
                }

                Button {
                } label: {
                    Label("Add to Shopping List", systemImage: "cart")
                }

                Button {
                    recipe.cookedCount += 1
                    recipe.lastPrepared = .now
                } label: {
                    Label("Log Cook", systemImage: "frying.pan")
                }

                VStack(spacing: 10) {
                    if (recipe.cookedCount > 0) {
                        Text("Cooked \(recipe.cookedCount) time\(recipe.cookedCount == 1 ? "" : "s")")
                            .foregroundStyle(.secondary)
                    }

                    if let lastPrepared = recipe.lastPrepared {
                        Text("Last prepared \(lastPrepared.formatted(date: .long, time: .shortened))")
                            .foregroundStyle(.secondary)
                    }

                    if let nextSchedule = recipe.schedule {
                        Text("Scheduled for \(nextSchedule.formatted(date: .long, time: .shortened))")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top)
            }
        }
        .sheet(isPresented: $showScheduleSheet) {
            let next7Days = Date().next(7)

            VStack {
                Text("Schedule")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom)

                if recipe.schedule ?? .now > .now {
                    VStack {
                        Text("Scheduled for \(recipe.schedule!.formatted(.dateTime.weekday(.wide).day().month(.wide)))")
                            .foregroundStyle(.secondary)

                        Button {
                            recipe.schedule = nil
                        } label: {
                            Label("Remove from Schedule", systemImage: "list.clipboard")
                                .labelStyle(.titleOnly)
                        }
                    }
                } else {
                    VStack {
                        ForEach(next7Days, id: \.self) { date in
                            Button {
                                recipe.schedule = date
                            } label: {
                                Text("\(date.formatted(.dateTime.weekday(.wide).day().month(.wide)))")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct RecipeHeader: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center, spacing: 16) {
                    Text("\(recipe.name)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    Group {
                        if recipe.favorite {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                }

                RecipeParameters(recipe: recipe)
            }

            Spacer()
        }
    }
}

struct Column1: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                RecipeImage(recipe: recipe)
                    .focusable()

                RecipeInfo(recipe: recipe)

                RecipeSummary(summary: recipe.summary)

                RecipeIngredients(ingredients: recipe.ingredients)
            }
        }
    }
}

struct Column2: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            InstructionsView(instructions: recipe.instructions)
        }
    }
}

struct RecipeImage: View {
    let recipe: Recipe

    var body: some View {
        if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(20)
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
                .scaleEffect(0.20)
        }
    }
}

struct RecipeInfo: View {
    let recipe: Recipe

    @FocusState private var isFocused: Bool

    var body: some View {
        Group {
            HStack {
                Spacer(minLength: 0)
                RecipeInfoUnit(title: "Prep Time", value: "\(recipe.prepTime) min")
                Divider()
                RecipeInfoUnit(title: "Cook Time", value: "\(recipe.cookingTime) min")
                Divider()
                RecipeInfoUnit(title: "Serves", value: "\(recipe.servingSize)")
                Spacer(minLength: 0)
            }
            .padding(.vertical)
//            .fixedSize(horizontal: false, vertical: true)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal)
        .focusable()
        .focused($isFocused)
        .scaleEffect(isFocused ? 1.02 : 1)
        .shadow(color: isFocused ? .black.opacity(0.3) : .clear, radius: 20, x: 0, y: 10)
        .animation(.easeInOut(duration: 0.1), value: isFocused)
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
                .lineLimit(1)
            Text(value)
                .font(.headline)
        }
    }
}

struct RecipeSummary: View {
    var summary: String

    @FocusState private var isFocused: Bool

    var body: some View {
        Text(summary)
            .font(.system(size: 40))
            .multilineTextAlignment(.center)
            .padding()
            .focusable()
            .focused($isFocused)
            .background(isFocused ? Color.gray.opacity(0.2) : Color.clear, in: RoundedRectangle(cornerRadius: 20))
            .animation(.easeInOut(duration: 0.1), value: isFocused)
    }
}

struct RecipeIngredients: View {
    var ingredients: [Ingredient]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.headline.smallCaps())
                .padding(.bottom, 4)

            VStack(spacing: 0) {
                ForEach(ingredients) { ingredient in
                    IngredientRow(ingredient: ingredient)
                }
            }
        }
    }
}

struct IngredientRow: View {
    var ingredient: Ingredient

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Text(ingredient.name)
            Spacer()
            Text("\(ingredient.quantity, specifier: "%.0f") \(ingredient.unit)")
        }
        .padding()
        .focusable()
        .focused($isFocused)
        .background(isFocused ? Color.gray.opacity(0.2) : Color.clear, in: RoundedRectangle(cornerRadius: 20))
        .animation(.easeInOut(duration: 0.1), value: isFocused)
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

    @FocusState private var focusedInstructionIndex: Int?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.headline.smallCaps())
                .padding(.horizontal)
                .padding(.bottom, 4)

            ForEach(instructions.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Step \(index + 1)")
                            .font(.headline)
                            .foregroundStyle(focusedInstructionIndex == index ? .primary : .secondary)

                        let instruction = instructions[index]
                        Text(instruction.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(focusedInstructionIndex == index ? .accentColor : .primary)

                        Text(instruction.instruction)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding()
                .focusable()
                .focused($focusedInstructionIndex, equals: index)
                .background(focusedInstructionIndex == index ? Color.gray.opacity(0.2) : Color.clear)
                .cornerRadius(20)
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
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Image(systemName: image)
                .font(.subheadline.smallCaps())
            Text(value)
                .font(.headline)
        }
    }
}

//#Preview {
//    RecipeDetail()
//        .modelContainer(for: Recipe.self, inMemory: true)
////        .recipeDataContainer(inMemory: true)
//}

