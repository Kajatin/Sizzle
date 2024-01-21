//
//  Favourites.swift
//  Sizzle
//
//  Created by Roland Kajatin on 03/12/2023.
//

import SwiftUI
import RecipeDataContainer

struct Favourites: View {
    @Binding var navigationPath: [Recipe]
    
    var body: some View {
        Text("Hello world")
            .navigationTitle("Favourites")
    }
}

#Preview {
    @State var path: [Recipe] = []
    return Favourites(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
