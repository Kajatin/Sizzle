//
//  RecipePreloadExamples.swift
//  
//
//  Created by Roland Kajatin on 14/05/2024.
//

import OSLog
import SwiftUI
import SwiftData

private let logger = Logger(subsystem: "RecipeDataContainer", category: "General")

struct RecipePreloadExamplesViewModifier: ViewModifier {
    init() {}
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard let defaults = UserDefaults(suiteName: "group.com.gmail.kajatin.roland.sizzle") else {
                    logger.error("UserDefaults not available")
                    return
                }
                
                if defaults.bool(forKey: "samplesLoaded") == false {
                    if let url = Bundle.main.url(forResource: "example-recipes", withExtension: "json") {
                        do {
                            let data = try Data(contentsOf: url)
                            let items = try JSONDecoder().decode([Recipe].self, from: data)
                            
                            // Populate the model container with the examples
                            let context = ModelContainerManager.shared.container.mainContext
                            for item in items {
                                context.insert(item)
                            }
                            try context.save()
                            
                            defaults.set(true, forKey: "samplesLoaded")
                        } catch {
                            logger.error("Error loading data: \(error)")
                        }
                    }
                }
            }
    }
}

public extension View {
    func recipePreloadExamples() -> some View {
        modifier(RecipePreloadExamplesViewModifier())
    }
}
