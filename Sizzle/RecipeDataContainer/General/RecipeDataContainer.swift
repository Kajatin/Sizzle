//
//  RecipeDataContainer.swift
//  RecipeDataContainer
//
//  Created by Roland Kajatin on 26/12/2023.
//

import OSLog
import SwiftUI
import SwiftData

private let logger = Logger(subsystem: "RecipeDataContainer", category: "General")

struct RecipeDataContainerViewModifier: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        let schema = Schema([
            Recipe.self,
        ])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        container = try! ModelContainer(for: schema, configurations: [configuration])
    }
    
    func body(content: Content) -> some View {
        content
            .modelContainer(container)
    }
}

public extension View {
    func recipeDataContainer(inMemory: Bool = RecipeDataOptions.inMemoryPersistence) -> some View {
        modifier(RecipeDataContainerViewModifier(inMemory: inMemory))
    }
}
