//
//  Schedule.swift
//  Sizzle
//
//  Created by Roland Kajatin on 29/11/2023.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct ScheduleView: View {
    @Binding var navigationPath: [Recipe]
    @Query(filter: #Predicate<Recipe> { recipe in
        recipe.schedule != nil
    }, sort: \Recipe.schedule) private var scheduledRecipes: [Recipe]

    let next7Days = Date().next(7)

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(next7Days, id: \.self) { day in
                    ScheduleRow(day: day, scheduledRecipes: scheduledRecipes.filter {
                        if $0.schedule == nil {
                            return false
                        }
                        
                        return Calendar.current.isDate($0.schedule!, inSameDayAs: day)
                    })
                    Divider()
                }
            }
        }
        .scenePadding()
        .navigationTitle("Schedule")
    }
}

struct ScheduleRow: View {
    var day: Date
    var scheduledRecipes: [Recipe]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(day.formatted(.dateTime.weekday(.wide).day().month(.wide)))")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(scheduledRecipes) { recipe in
                        ScheduleCard(recipe: recipe)
                    }

                    ScheduleNew(day: day, atLeastOne: scheduledRecipes.count > 0)
                }
            }
        }
    }
}

struct ScheduleCard: View {
    var recipe: Recipe

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 10) {
                Text("\(recipe.name)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)

                Button {
                    recipe.favorite.toggle()
                } label: {
                    Group {
                        if recipe.favorite {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                    }
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                }
            }
            .frame(width: 240, alignment: .leading)

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
            .frame(width: 240, height: 180)
            .background(.regularMaterial)
            .overlay(alignment: .topTrailing) {
                Menu {
                    Button {

                    } label: {
                        Label("View Recipe", systemImage: "book.pages")
                    }

                    Button {

                    } label: {
                        Label("Add to Shopping List", systemImage: "cart")
                    }

                    Button(role: .destructive) {
                        withAnimation {
                            recipe.schedule = nil
                        }
                    } label: {
                        Label("Unschedule", systemImage: "xmark")
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis")
                        .labelStyle(.iconOnly)
                        .scenePadding()
                        .foregroundColor(.primary)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                        .padding([.top, .trailing], 5)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct ScheduleNew: View {
    var day: Date
    var atLeastOne = false

    @State private var showScheduleRecipeView = false

    var body: some View {
        VStack(alignment: .leading) {
            if atLeastOne {
                Text(" ")
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            Button {
                showScheduleRecipeView.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .tint(.secondary)
                    .frame(minWidth: 30, maxWidth: 50, minHeight: 30, maxHeight: 50)
                    .aspectRatio(4/3, contentMode: .fit)
                    .frame(width: 240, height: 180)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .sheet(isPresented: $showScheduleRecipeView) {
            ScheduleRecipeSheet(day: day)
        }
    }
}

struct ScheduleRecipeSheet: View {
    var day: Date

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScheduleRecipe(day: day)
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
}

struct ScheduleRecipe: View {
    var day: Date

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.created) private var recipes: [Recipe]

    var body: some View {
        VStack {
            Text("\(day.formatted())")
            Button {
                withAnimation {
                    let r = recipes.first!
                    r.schedule = day
                }
            } label: {
                Text("Add")
            }
        }
    }
}

extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }

    func next(_ n: Int) -> [Date] {
        var dates: [Date] = []
        for i in 0..<n {
            dates.append(Calendar.current.date(byAdding: .day, value: i, to: self)!)
        }
        return dates
    }
}

#Preview {
    @State var path: [Recipe] = []
    return ScheduleView(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
