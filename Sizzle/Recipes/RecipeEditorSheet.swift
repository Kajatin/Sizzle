//
//  RecipeEditorSheet.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

struct RecipeEditorSheet: View {
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            RecipeEditor(recipe: recipe)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                        }
                    }
                }
        }
    }
}

struct RecipeEditor: View {
    @State var recipe: Recipe
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Name", text: $recipe.name)
                TextField("Summary", text: $recipe.summary)
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
            
            Section(header: Text("Ingredients")) {
                ForEach($recipe.ingredients) { $ingredient in
                    HStack {
                        TextField("Name", text: $ingredient.name)
                        Spacer()
                        TextField("Quantity", value: $ingredient.quantity, format: .number)
                        TextField("Unit", text: $ingredient.unit)
                    }
                }
                Button("Add Ingredient") {
                    recipe.ingredients.append(Ingredient(name: "", quantity: 0, unit: ""))
                }
            }
            
            Section(header: Text("Instructions")) {
                ForEach($recipe.instructions.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        TextField("Title", text: $recipe.instructions[index].title)
                        TextField("Instruction", text: $recipe.instructions[index].instruction)
                    }
                }
                Button("Add Instruction") {
                    recipe.instructions.append(Instruction(title: "", instruction: ""))
                }
            }
            
            Section(header: Text("Serving Size")) {
                Stepper("\(recipe.servingSize) servings", value: $recipe.servingSize, in: 1...20)
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
