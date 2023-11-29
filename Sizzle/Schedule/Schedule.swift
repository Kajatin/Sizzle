//
//  Schedule.swift
//  Sizzle
//
//  Created by Roland Kajatin on 29/11/2023.
//

import SwiftUI

struct Schedule: View {
    @Binding var navigationPath: [Recipe]
    
    var body: some View {
        Text("Hello world")
        .navigationTitle("Schedule")
    }
}

#Preview {
    @State var path: [Recipe] = []
    return Schedule(navigationPath: $path)
        .modelContainer(for: Recipe.self, inMemory: true)
}
