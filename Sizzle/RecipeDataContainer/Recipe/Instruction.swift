//
//  Instruction.swift
//
//
//  Created by Roland Kajatin on 26/12/2023.
//

import Foundation

public struct Instruction: Identifiable, Codable {
    public var id = UUID()
    public var title: String
    public var instruction: String
    
    public init(title: String, instruction: String) {
        self.title = title
        self.instruction = instruction
    }
}
