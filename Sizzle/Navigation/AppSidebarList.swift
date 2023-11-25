//
//  AppSidebarList.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Sizzle")
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.recipes))
    } detail: {
        Text(verbatim: "Check out that sidebar!")
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
