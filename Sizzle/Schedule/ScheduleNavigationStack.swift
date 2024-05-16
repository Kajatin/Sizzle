//
//  ScheduleNavigationStack.swift
//  Sizzle
//
//  Created by Roland Kajatin on 29/11/2023.
//

import SwiftUI
import RecipeDataContainer

struct ScheduleNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ScheduleView(navigationPath: $path)
        }
    }
}

#Preview {
    ScheduleNavigationStack()
        .recipeDataContainer(inMemory: true)
}
