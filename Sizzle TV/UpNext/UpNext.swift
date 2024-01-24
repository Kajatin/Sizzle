//
//  UpNext.swift
//  Sizzle TV
//
//  Created by Roland Kajatin on 21/01/2024.
//

import SwiftUI
import SwiftData
import RecipeDataContainer

struct UpNext: View {
    @Binding var navigationPath: [Recipe]

    @Query(filter: #Predicate<Recipe> { recipe in
        recipe.schedule != nil
    }, sort: \Recipe.schedule) private var recipes: [Recipe]
    
    let next7Days = Date().next(7)

    var body: some  View {
        ScrollView(.horizontal) {
            HStack(spacing: 30) {
                ForEach(next7Days, id: \.self) { day in
                    ScheduleCard(day: day, recipes: recipes.filter {
                        return Calendar.current.isDate($0.schedule!, inSameDayAs: day)
                    })
                    
                    if day != next7Days.last {
                        Divider()
                    }
                }
            }
        }
        .navigationDestination(for: Recipe.self) { recipe in
            EmojiBackground()
                .overlay {
                    RecipeDetail(recipe: recipe)
                }
        }
    }
}

struct ScheduleCard: View {
    var day: Date
    var recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 40) {
                Text("\(day.formatted(.dateTime.weekday(.wide).day().month(.wide)))")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                if recipes.count > 0 {
                    ForEach(recipes, id: \.self) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeTile(recipe: recipe)
                        }
                        .buttonStyle(
                            RecipeTileButtonStyle()
                        )
                    }
                } else {
                    Text("Nothing scheduled")
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(.vertical)
            .frame(minWidth: 400)
            .focusSection()
        }
        .padding()
//        .background(.pastelBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .if(recipes.count == 0) { view in
            view.focusable()
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

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    @State var path: [Recipe] = []

    return UpNext(navigationPath: $path)
        .recipeDataContainer(inMemory: true)
}
