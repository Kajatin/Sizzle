//
//  SizzleApp.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

@main
struct SizzleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .recipeDataContainer()
        }
    }
}
