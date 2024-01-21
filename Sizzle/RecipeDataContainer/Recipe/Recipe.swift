//
//  Recipe.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import SwiftData
import Foundation

@Model
public final class Recipe: Identifiable {
    public var uuid = UUID()
    public var name: String = "New Recipe"
    public var summary: String = ""
    @Attribute(.externalStorage)
    public var image: Data?
    public var difficulty: Difficulty = Difficulty.medium
    public var prepTime: Int = 15
    public var cookingTime: Int = 60
    public var ingredients: [Ingredient] = []
    public var instructions: [Instruction] = []
    public var servingSize: Int = 4
    public var cuisineType: Cuisine = Cuisine.other
    public var mealType: MealType = MealType.other
//    var keywords: [String]
//    var allergens: [Allergen]
    public var created: Date = Date.now
    public var cookedCount: Int = 0
    public var lastPrepared: Date?
    public var favorite: Bool = false
    public var schedule: Date?

    public init() {}
}

public extension Recipe {
    static func example() -> Recipe {
        let recipe = Recipe()
        recipe.name = "Tortilla de Patatas"
        recipe.summary = "Torilla de patatas is a traditional Spanish dish consisting of an egg omelette made with potatoes and fried in olive oil. It is considered a national dish of Spain, and is regularly served as a tapa."
        recipe.difficulty = .easy
        recipe.prepTime = 15
        recipe.cookingTime = 60
        recipe.ingredients = [
            Ingredient(name: "Potatoes", quantity: 500, unit: "g"),
            Ingredient(name: "Eggs", quantity: 6, unit: ""),
            Ingredient(name: "Onion", quantity: 1, unit: ""),
            Ingredient(name: "Olive Oil", quantity: 250, unit: "ml"),
            Ingredient(name: "Salt", quantity: 1, unit: "pinch"),
        ]
        recipe.instructions = [
            Instruction(title: "Peel and slice the potatoes", instruction: "Peel the potatoes and cut them into thin slices. Peel and slice the onion."),
            Instruction(title: "Fry the potatoes and onion", instruction: "Heat the oil in a non-stick frying pan and add the potatoes and onion. Cook over a low heat for 30 minutes, stirring occasionally. The potatoes should be soft but not brown."),
            Instruction(title: "Beat the eggs", instruction: "Break the eggs into a large bowl and beat them lightly with a fork. Add a pinch of salt."),
            Instruction(title: "Add the potatoes and onion", instruction: "When the potatoes and onion are cooked, drain them in a colander set over a bowl to collect the oil. Add them to the eggs and mix well."),
            Instruction(title: "Cook the tortilla", instruction: "Heat 2 tablespoons of the oil in a non-stick frying pan. When the oil is hot, add the egg mixture, spreading it out evenly. Cook over a low heat for 4-5 minutes, shaking the pan occasionally. When the tortilla is golden underneath, place a flat lid or plate over the pan and turn the tortilla out onto it. Add another tablespoon of oil to the pan and slide the tortilla back in, uncooked side down. Cook for a further 4-5 minutes, then turn the heat off and leave the tortilla to settle for a few minutes. Serve warm or cold, cut into wedges."),
        ]
        recipe.servingSize = 4
        recipe.cuisineType = .spanish
        recipe.mealType = .lunch
        recipe.created = .now
        recipe.lastPrepared = .now
        return recipe
    }
}
