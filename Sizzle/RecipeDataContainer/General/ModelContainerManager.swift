//
//  ModelContainerManager.swift
//
//
//  Created by Roland Kajatin on 14/05/2024.
//

import SwiftData
import Foundation

class ModelContainerManager {
    let container: ModelContainer
    
    static let shared = ModelContainerManager(inMemory: false)
    static let sharedInMemory = ModelContainerManager(inMemory: true)
    
    init(inMemory: Bool) {
        let schema = Schema([
            Recipe.self,
        ])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        container = try! ModelContainer(for: schema, configurations: [configuration])
    }
}
