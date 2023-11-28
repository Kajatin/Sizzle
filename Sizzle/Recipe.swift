//
//  Recipe.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import Foundation
import SwiftData

@Model
final class Recipe: Identifiable {
    var uuid = UUID()
    var name: String
    var summary: String
    @Attribute(.externalStorage) var image: Data?
    var difficulty: Difficulty
    var prepTime: Int
    var cookingTime: Int
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var servingSize: Int
    var cuisineType: Cuisine
    var mealType: MealType
//    var keywords: [String]
//    var allergens: [Allergen]
    var created: Date
    var cookedCount: Int
    var lastPrepared: Date?
    var favorite: Bool

    init() {
        self.name = "New Recipe"
        self.summary = ""
        self.difficulty = .medium
        self.prepTime = 15
        self.cookingTime = 60
        self.ingredients = []
        self.instructions = []
        self.servingSize = 4
        self.cuisineType = .other
        self.mealType = .other
        self.created = .now
        self.cookedCount = 0
        self.favorite = false
    }

    // static function to create a new example recipe
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

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy
    case medium
    case hard

    var id: String { self.rawValue }
}

enum Cuisine: String, CaseIterable, Identifiable, Codable {
    case spanish
    case italian
    case french
    case chinese
    case indian
    case mexican
    case japanese
    case thai
    case greek
    case turkish
    case lebanese
    case vietnamese
    case korean
    case american
    case british
    case german
    case portuguese
    case swedish
    case polish
    case russian
    case irish
    case scottish
    case welsh
    case australian
    case brazilian
    case argentinian
    case peruvian
    case colombian
    case venezuelan
    case chilean
    case cuban
    case dominican
    case haitian
    case jamaican
    case puertoRican
    case salvadoran
    case uruguayan
    case other

    var id: String { self.rawValue }
}

enum MealType: String, CaseIterable, Identifiable, Codable {
    case breakfast
    case lunch
    case dinner
    case dessert
    case snack
    case appetizer
    case drink
    case other

    var id: String { self.rawValue }
}

struct Ingredient: Identifiable, Codable {
    var id = UUID()
    var name: String
    var quantity: Double
    var unit: String
}

struct Instruction: Identifiable, Codable {
    var id = UUID()
    var title: String
    var instruction: String
}
