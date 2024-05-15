//
//  RecipeDataContainer.swift
//  RecipeDataContainer
//
//  Created by Roland Kajatin on 26/12/2023.
//

import OSLog
import SwiftUI

private let logger = Logger(subsystem: "RecipeDataContainer", category: "General")

struct RecipeDataContainerViewModifier: ViewModifier {
    let manager: ModelContainerManager
    
    init(inMemory: Bool) {
        if inMemory {
            manager = ModelContainerManager.sharedInMemory
        } else {
            manager = ModelContainerManager.shared
        }
    }
    
    func body(content: Content) -> some View {
        content
            .modelContainer(manager.container)
    }
}

public extension View {
    func recipeDataContainer(inMemory: Bool = RecipeDataOptions.inMemoryPersistence) -> some View {
        modifier(RecipeDataContainerViewModifier(inMemory: inMemory))
    }
}
