//
//  Sizzle_TVApp.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 07/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

@main
struct Sizzle_TVApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .recipeDataContainer()
                .recipePreloadExamples()
        }
    }
}
