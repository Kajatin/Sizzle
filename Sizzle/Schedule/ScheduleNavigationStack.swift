//
//  ScheduleNavigationStack.swift
//  Sizzle
//
//  Created by Roland Kajatin on 29/11/2023.
//

import SwiftUI

struct ScheduleNavigationStack: View {
    @State private var path: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Schedule(navigationPath: $path)
        }
    }
}

#Preview {
    ScheduleNavigationStack()
        .modelContainer(for: Recipe.self, inMemory: true)
}
