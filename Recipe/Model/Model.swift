//
//  Model.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 24/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation
import RealmSwift

struct SearchModel: Decodable {
    var results: [Recipe]
}
struct Model: Decodable {
    var recipes: [Recipe]
}

struct Recipe: Decodable {
    var id: Int?
    var vegetarian: Bool?
    var vegan: Bool?
    var extendedIngredients: [ExtendedIngredient]?
    var glutenFree: Bool?
    var dairyFree: Bool?
    var veryHealthy: Bool?
    var cheap: Bool?
    var veryPopular: Bool?
    var weightWatcherSmartPoints: Float?
    var aggregateLikes: Int?
    var spoonacularScore: Int
    var healthScore: Int?
    var servings: Int
    var title: String?
    var author: String?
    var readyInMinutes: Int?
    var image: String?
    var summary: String?
    var cuisines: [String]?
    var pricePerServing: Float?
}

struct ExtendedIngredient: Decodable {
    var id: Int?
    var aisle: String?
    var consistency: String?
    var original: String?
    var amount: Double?
}

//Realm models
class IngredientToBuy: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var tag: Int = 0
}

class CachedRecipe: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var cheap: Bool = false
    @objc dynamic var spoonacularScore: Int = 0
    @objc dynamic var servings: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var readyInMinutes: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var pricePerServing: Float = 0.0
    var extendedIngredients = List<CachedIngredient>()
}

class CachedIngredient: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var aisle: String = ""
    @objc dynamic var consistency: String = ""
    @objc dynamic var original: String = ""
    @objc dynamic var amount: Double = 0.0
}
