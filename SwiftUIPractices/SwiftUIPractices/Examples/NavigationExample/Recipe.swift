//
//  Recipe.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import Foundation

struct Category: Identifiable, Hashable {
    var id: UUID = .init()
    var name: String
    var recipes: [Recipe]
}

struct Recipe: Identifiable, Hashable {
    var id: UUID = .init()
    var category: UUID
    var name: String
    var description: String
}

let dessertsCategoryId: UUID = .init()
let breakfastsCategoryId: UUID = .init()

func createRecipeData() -> [Category] {
    let desserts = [
        Recipe(category: dessertsCategoryId, name: "Apple Pie", description: "A classic American dessert."),
        Recipe(category: dessertsCategoryId, name: "Chocolate Lava Cakes", description: "Individual molten chocolate cakes with a gooey center."),
        Recipe(category: dessertsCategoryId, name: "Strawberry Shortcake", description: "A summertime favorite, made with fresh strawberries and biscuits."),
        Recipe(category: dessertsCategoryId, name: "Mousse au Chocolat", description: "Rich and creamy French mousse with a smooth chocolate finish."),
    ]
    let breakfasts = [
        Recipe(category: breakfastsCategoryId, name: "French Toast", description: "Sliced bread dipped in egg mixture and fried until golden brown."),
        Recipe(category: breakfastsCategoryId, name: "Avocado Toast with Poached Egg", description: "Toast spread with mashed avocado, topped with a poached egg, and sprinkled with salt and pepper."),
        Recipe(category: breakfastsCategoryId, name: "Smoothie Bowl", description: "A nutrient-packed bowl topped with fresh fruits, granola, and coconut flakes."),
    ]
    let categoryDesserts = Category(
        id: dessertsCategoryId,
        name: "Desserts",
        recipes: desserts
    )
    let categoryBreakfast = Category(
        id: breakfastsCategoryId,
        name: "Breakfast",
        recipes: breakfasts
    )
    return [categoryDesserts, categoryBreakfast]
}
