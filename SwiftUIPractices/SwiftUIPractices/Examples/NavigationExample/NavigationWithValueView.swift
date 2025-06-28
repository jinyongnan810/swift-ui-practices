//
//  NavigationWithValueView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import SwiftUI

struct NavigationWithValueView: View {
    let recipeData = createRecipeData()
    @State var path: [Recipe] = []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(recipeData) { category in
                    Section(category.name) {
                        ForEach(category.recipes) { recipe in
                            NavigationLink(recipe.name, value: recipe)
                        }
                    }
                }
            }.navigationTitle("Categories")
                .navigationDestination(for: Recipe.self) { recipe in
                    let all = recipeData.first(where: { cat in
                        cat.id == recipe.category
                    })?.recipes ?? []
                    let exceptCurrent = all.filter { $0.id != recipe.id }
                    RecipeDetailView(recipe: recipe, related: exceptCurrent, callbackForSplitView: nil)
                }
                // manually chaning the path will automatically change stack
                .onChange(of: path) { old, new in
                    print("path changed: \(old) -> \(new)")
                }
        }
    }
}

#Preview {
    NavigationWithValueView()
}
