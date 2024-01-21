//
//  Ingredient.swift
//  
//
//  Created by Roland Kajatin on 26/12/2023.
//

import Foundation

public struct Ingredient: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    public var quantity: Double
    public var unit: String
    
    public init(name: String, quantity: Double, unit: String) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
