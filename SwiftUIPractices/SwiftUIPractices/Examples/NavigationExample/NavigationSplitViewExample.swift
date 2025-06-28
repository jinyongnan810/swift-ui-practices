//
//  NavigationSplitViewExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import SwiftUI

struct NavigationSplitViewExample: View {
    let recipeData = createRecipeData()
    @State private var selectedCategory: Category?
    @State private var selectedRecipe: Recipe?
    var recipesInSelectedCategory: [Recipe] {
        selectedCategory?.recipes ?? []
    }

    var relatedRecipesFOrSelectedRecipe: [Recipe] {
        if selectedRecipe == nil {
            return []
        }
        let all = recipeData.first(where: { cat in
            cat.id == selectedRecipe!.category
        })?.recipes ?? []
        let exceptCurrent = all.filter { $0.id != selectedRecipe!.id }
        return exceptCurrent
    }

    var body: some View {
        NavigationSplitView {
            List(recipeData, selection: $selectedCategory) { category in
                NavigationLink(category.name, value: category)
            }.navigationTitle("Categories")
        } content: {
            List(
                recipesInSelectedCategory,
                selection: $selectedRecipe
            ) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }.navigationTitle(selectedCategory?.name ?? "No Category Selected")
        } detail: {
            if selectedRecipe != nil {
                RecipeDetailView(
                    recipe: selectedRecipe!,
                    related: relatedRecipesFOrSelectedRecipe,
                    callbackForSplitView: { recipe in
                        withAnimation {
                            selectedRecipe = recipe
                        }
                    }
                )
            } else {
                Text("No recipe selected")
            }
        }
    }
}

#Preview {
    NavigationSplitViewExample()
}
