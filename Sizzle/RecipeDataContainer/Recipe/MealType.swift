//
//  MealType.swift
//  
//
//  Created by Roland Kajatin on 26/12/2023.
//

import Foundation

public enum MealType: String, CaseIterable, Identifiable, Codable {
    case breakfast
    case lunch
    case dinner
    case dessert
    case snack
    case appetizer
    case drink
    case other
    
    public var id: String { self.rawValue }
}
