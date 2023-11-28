//
//  RecipeEditorSheet.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

////    var image: UIImage

import SwiftUI
import PhotosUI

struct RecipeEditorSheet: View {
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            RecipeEditor(recipe: recipe)
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
}

struct RecipeEditor: View {
    @State var recipe: Recipe
    @State var selectedItem: PhotosPickerItem?
    @State var uiImage: UIImage?
    @State var showCameraPicker = false
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Name", text: $recipe.name)
                TextField("Summary", text: $recipe.summary)
            }
            
            Section(header: Text("Photo")) {
                if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity, maxHeight: 250)
                }
                Button {
                    showCameraPicker = true
                } label: {
                    Text("Take Photo")
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Select Photo")
                }
                if recipe.image != nil {
                    Button(role: .destructive) {
                        withAnimation {
                            recipe.image = nil
                        }
                    } label: {
                        Text("Remove Image")
                    }
                }
            }
            
            Section(header: Text("Details")) {
                Picker("Meal", selection: $recipe.mealType) {
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        Text(mealType.rawValue.capitalized).tag(mealType)
                    }
                }
                Picker("Cuisine", selection: $recipe.cuisineType) {
                    ForEach(Cuisine.allCases, id: \.self) { cuisine in
                        Text(cuisine.rawValue.capitalized).tag(cuisine)
                    }
                }
                Picker("Difficulty", selection: $recipe.difficulty) {
                    ForEach(Difficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue.capitalized).tag(difficulty)
                    }
                }
            }
            
            Section(header: Text("Time")) {
                FluidStepper(title: "Preparation Time: \(recipe.prepTime ) minutes", value: $recipe.prepTime)
                FluidStepper(title: "Cooking Time: \(recipe.cookingTime) minutes", value: $recipe.cookingTime)
            }
            
            Section(header: Text("Serving Size")) {
                Stepper("\(recipe.servingSize) servings", value: $recipe.servingSize, in: 1...20)
            }
            
            Section(header: Text("Ingredients")) {
                ForEach($recipe.ingredients) { $ingredient in
                    HStack {
                        TextField("Name", text: $ingredient.name)
                        Divider()
                        TextField("Quantity", value: $ingredient.quantity, format: .number)
                        Divider()
                        TextField("Unit", text: $ingredient.unit)
                            .textInputAutocapitalization(.never)
                    }
                }
                .onDelete(perform: { indexSet in
                    recipe.ingredients.remove(atOffsets: indexSet)
                })
                Button("Add Ingredient") {
                    recipe.ingredients.append(Ingredient(name: "", quantity: 0, unit: ""))
                }
            }
            
            Section(header: Text("Instructions")) {
                ForEach($recipe.instructions.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text("Step \(index + 1)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        TextField("Title", text: $recipe.instructions[index].title)
                            .font(.title3)
                            .fontWeight(.semibold)
                        TextField("Instruction", text: $recipe.instructions[index].instruction)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                }
                .onDelete(perform: { indexSet in
                    recipe.instructions.remove(atOffsets: indexSet)
                })
                Button("Add Instruction") {
                    recipe.instructions.append(Instruction(title: "", instruction: ""))
                }
            }
        }
        .fullScreenCover(isPresented: $showCameraPicker) {
            CameraPicker() { image in
                recipe.image = image.jpegData(compressionQuality: 0.9)
            }
        }
        .task(id: selectedItem) {
            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                recipe.image = data
            }
        }
    }
}

struct FluidStepper: View {
    var title: String
    @Binding var value: Int
    @State private var stepCount = 0
    @State private var stepValue = 1
    @State private var resetTimer: Timer?
    @State private var lastStepTime = Date()
    
    var body: some View {
        Stepper(title, onIncrement: {
            incrementStep()
        }, onDecrement: {
            decrementStep()
        })
    }
    
    private func incrementStep() {
        startResetTimer()
        updateStepValue()
        value += stepValue
    }
    
    private func decrementStep() {
        startResetTimer()
        updateStepValue()
        value = max(0, value - stepValue)
    }
    
    private func updateStepValue() {
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(lastStepTime)
        lastStepTime = Date()
        
        var incrementBy = 0
        if timeDifference <= 0.2 { // User is pressing quickly
            incrementBy = 1
        }
        
        stepCount += incrementBy
        switch stepCount {
        case 0...6:
            stepValue = 1
        case 7...14:
            stepValue = 5
        default:
            stepValue = 10
        }
    }
    
    private func startResetTimer() {
        resetTimer?.invalidate()
        resetTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            self.stepCount = 0
            self.stepValue = 1
        }
    }
}

#Preview {
    var recipe = Recipe()
    return RecipeEditorSheet(recipe: recipe)
}
