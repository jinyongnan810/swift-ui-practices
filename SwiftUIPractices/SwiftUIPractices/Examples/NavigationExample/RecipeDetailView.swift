//
//  RecipeDetailView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    let related: [Recipe]
    let callbackForSplitView: ((Recipe) -> Void)?

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(recipe.name)
                    .font(.largeTitle)
                Text(recipe.description)
                    .font(.body)
            }
            Spacer()
            VStack {
                Text("Related Recipes")
                    .font(.headline)
                ForEach(related) { r in
                    if callbackForSplitView != nil {
                        Button(r.name) {
                            callbackForSplitView?(r)
                        }.padding(3)
                    } else {
                        NavigationLink(r.name, value: r).padding(3)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(
        recipe: Recipe(
            category: breakfastsCategoryId,
            name: "French Toast",
            description: "Sliced bread dipped in egg mixture and fried until golden brown."
        ),
        related: [
            Recipe(
                category: breakfastsCategoryId,
                name: "Some other French Toast",
                description: "Some other description"
            ),
        ],
        callbackForSplitView: nil
    )
}
