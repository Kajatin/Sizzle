//
//  Cuisine.swift
//  
//
//  Created by Roland Kajatin on 26/12/2023.
//

import Foundation

public enum Cuisine: String, CaseIterable, Identifiable, Codable {
    case american
    case argentinian
    case australian
    case brazilian
    case british
    case chinese
    case danish
    case french
    case german
    case greek
    case hungarian
    case indian
    case italian
    case japanese
    case korean
    case lebanese
    case mexican
    case polish
    case portuguese
    case russian
    case spanish
    case swedish
    case thai
    case turkish
    case vietnamese
    case other
    
    public var id: String { self.rawValue }
}
