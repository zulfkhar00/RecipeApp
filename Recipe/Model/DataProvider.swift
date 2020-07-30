//
//  DataProvider.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 24/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

protocol DataProviderDelegate {
    func getRecipes(recipes: [Recipe])
    func getSearch(results: [Recipe])
}

class DataProvider {
    var delegate: DataProviderDelegate?
    let apiKey = "f6498c1bfd6447a8a4ff4cee4ef2cc51"
    var baseUrl = "https://api.spoonacular.com/recipes"
    
    func fetchData() {
        let requestString = "\(baseUrl)/random?apiKey=\(apiKey)&number=50"
        guard let url = URL(string: requestString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let safeData = data else {return}
            
            do {
                let results = try JSONDecoder().decode(Model.self, from: safeData)
                self?.delegate?.getRecipes(recipes: results.recipes)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func searchByIngredient(name: String) {
        let requestString = "\(baseUrl)/complexSearch?apiKey=\(apiKey)&query=\(name)&instructionsRequired=true&fillIngredients=true&addRecipeInformation=true"
        guard let url = URL(string: requestString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let safeData = data else {return}
            
            do {
                let results = try JSONDecoder().decode(SearchModel.self, from: safeData)
                self?.delegate?.getSearch(results: results.results)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
