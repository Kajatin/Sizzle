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
//    var image: UIImage
    var difficulty: Difficulty
    var prepTime: Int
    var cookingTime: Int
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var servingSize: Int
//    var cuisinType: Cuisin
//    var keywords: [String]
//    var allergens: [Allergen]
    var created: Date
    
    init() {
        self.name = "New Recipe"
        self.summary = ""
        self.difficulty = .medium
        self.prepTime = 15
        self.cookingTime = 60
        self.ingredients = []
        self.instructions = []
        self.servingSize = 4
        self.created = .now
    }
}

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy
    case medium
    case hard
    
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
