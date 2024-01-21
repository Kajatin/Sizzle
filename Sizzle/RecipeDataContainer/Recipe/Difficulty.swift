//
//  Difficulty.swift
//
//
//  Created by Roland Kajatin on 26/12/2023.
//

import Foundation

public enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy
    case medium
    case hard
    
    public var id: String { self.rawValue }
}
