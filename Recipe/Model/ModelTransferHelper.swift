//
//  ModelTransferHelper.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 29/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

struct ModelTransferHelper {
    static func fromCachedToRecipe(_ recipe: CachedRecipe?) -> Recipe? {
        guard let recipe = recipe else {return nil}
        let id = recipe.id
        let cheap = recipe.cheap
        let spoonacularScore = recipe.spoonacularScore
        let servings = recipe.servings
        let title = recipe.title
        let readyInMinutes = recipe.readyInMinutes
        let image = recipe.image
        let summary = recipe.summary
        let pricePerServing = recipe.pricePerServing
        
        let ingredients = Array(recipe.extendedIngredients)
        var extendedIngredients = [ExtendedIngredient]()
        
        for ingredient in ingredients {
            let id = ingredient.id
            let aisle = ingredient.aisle
            let consistency = ingredient.consistency
            let original = ingredient.original
            let amount = ingredient.amount
            let extendedIngredient = ExtendedIngredient(id: id, aisle: aisle, consistency: consistency, original: original, amount: amount)
            extendedIngredients.append(extendedIngredient)
        }
        
        let recipeModel = Recipe(id: id, extendedIngredients: extendedIngredients, cheap: cheap, spoonacularScore: spoonacularScore, servings: servings, title: title, readyInMinutes: readyInMinutes, image: image, summary: summary, pricePerServing: pricePerServing)
        return recipeModel
    }
}

