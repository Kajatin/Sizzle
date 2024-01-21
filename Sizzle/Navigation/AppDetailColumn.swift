//
//  AppDetailColumn.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI
import SwiftData

struct AppDetailColumn: View {
    var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView("Select a Recipe", systemImage: "bird", description: Text("Pick something from the list."))
            }
        }
#if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
#endif
    }
}

#Preview {
    AppDetailColumn()
        .recipeDataContainer(inMemory: true)
}
