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
}

struct DataProvider {
    var delegate: DataProviderDelegate?
    let apiKey = "f6498c1bfd6447a8a4ff4cee4ef2cc51"
    var baseUrl = "https://api.spoonacular.com/recipes/random"
    
    func fetchData() {
        let requestString = "\(baseUrl)?apiKey=\(apiKey)&number=15"
        guard let url = URL(string: requestString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let safeData = data else {return}
            
            do {
                let results = try JSONDecoder().decode(Model.self, from: safeData)
                self.delegate?.getRecipes(recipes: results.recipes)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
