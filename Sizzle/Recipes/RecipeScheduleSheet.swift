//
//  RecipeScheduleSheet.swift
//  Sizzle
//
//  Created by Roland Kajatin on 16/12/2023.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct RecipeScheduleSheet: View {
    var recipe: Recipe
    @Binding var navigationPath: [Recipe]

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            RecipeScheduler(recipe: recipe, navigationPath: $navigationPath)
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
                .navigationTitle("\(recipe.name)")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RecipeScheduler: View {
    @State var recipe: Recipe
    @Binding var navigationPath: [Recipe]

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var date: Date = .now

    let scheduleRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let nextWeek = calendar.date(byAdding: .day, value: 6, to: today)!
        return today...nextWeek
    }()

    var body: some View {
        Form {
            Section {
                GeometryReader { geometry in
                    Group {
                        if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .tint(.secondary)
                                .frame(minWidth: 50, maxWidth: 70, minHeight: 50, maxHeight: 70)
                        }
                    }
                    .aspectRatio(4/3, contentMode: .fit)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9 * 3 / 4)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                .frame(height: UIScreen.main.bounds.width * 0.9 * 3 / 4)
            }
            .padding(0)

            Section(header: Text("Schedule Details")) {
                DatePicker("Date", selection: $date, in: scheduleRange, displayedComponents: [.date])

                Button {
                    withAnimation {
                        recipe.schedule = date
                        dismiss()
                    }
                } label: {
                    Text("Schedule")
                }
            }
        }
    }
}

#Preview {
    let recipe = Recipe()
    @State var path: [Recipe] = []
    return RecipeScheduleSheet(recipe: recipe, navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}

