//
//  NavigationSplitViewWithValueExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import SwiftUI

struct NavigationSplitViewWithValueExample: View {
    @State var path: [Recipe] = []
    let recipeData = createRecipeData()
    @State private var selectedCategory: Category?
    var recipesInSelectedCategory: [Recipe] {
        selectedCategory?.recipes ?? []
    }

    var body: some View {
        NavigationSplitView {
            List(recipeData, selection: $selectedCategory) { category in
                NavigationLink(category.name, value: category)
            }.navigationTitle("Categories")
        } detail: {
            NavigationStack(path: $path) {
                List(
                    recipesInSelectedCategory
                ) { recipe in
                    NavigationLink(recipe.name, value: recipe)
                }
                .navigationTitle(selectedCategory?.name ?? "No Category Selected")
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
}

#Preview {
    NavigationSplitViewWithValueExample()
}
