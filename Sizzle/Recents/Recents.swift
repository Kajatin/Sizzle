//
//  Recents.swift
//  Sizzle
//
//  Created by Roland Kajatin on 03/12/2023.
//

import SwiftUI
import RecipeDataContainer

struct Recents: View {
    @Binding var navigationPath: [Recipe]
    
    var body: some View {
        Text("Hello world")
            .navigationTitle("Recents")
    }
}

#Preview {
    @State var path: [Recipe] = []
    return Recents(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
