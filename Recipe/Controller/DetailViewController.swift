//
//  DetailViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 25/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var reviewScoreLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var pricePerServingLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    let realm = try! Realm()
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        guard let numOfIngredients = recipe?.extendedIngredients?.count else {return}
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(60*numOfIngredients)).isActive = true
        
        guard let imageURL = recipe?.image else {return}
        guard let spoonacularScore = recipe?.spoonacularScore else {return}
        guard let readyInMinutes = recipe?.readyInMinutes else {return}
        guard let pricePerServing = recipe?.pricePerServing else {return}
        guard let servings = recipe?.servings else {return}
        recipeImageView.sd_setImage(with: URL(string: imageURL))
        recipeTitle.text = recipe?.title
        reviewScoreLabel.text = "\(spoonacularScore)%"
        cookTimeLabel.text = "\(readyInMinutes)min"
        pricePerServingLabel.text = String(format: "$%.1f", pricePerServing)
        servingsLabel.text = "\(servings)"
        guard var summary = recipe?.summary else {return}
        summary = summary.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression)
        summaryLabel.text = summary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let id = recipe?.id else {return}
        let results = realm.objects(CachedRecipe.self)
        
        for recipe in results {
            if recipe.id == id {
                likeButton.setImage(UIImage(named: "starFilled"), for: .normal)
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.extendedIngredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        cell.ingredientLabel.text = recipe?.extendedIngredients?[indexPath.row].original
        cell.tempIngredient = recipe?.extendedIngredients?[indexPath.row].original
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    @IBAction func likeButtonPressed(_ sender: UIButton) {
        guard let id = recipe?.id else {return}
        
        let results = realm.objects(CachedRecipe.self)
        for recipe in results {
            if recipe.id == id {
                try! realm.write {
                    realm.delete(recipe)
                }
                sender.setImage(UIImage(named: "star"), for: .normal)
                return
            }
        }
        
        let newCachedRecipe = CachedRecipe()
        newCachedRecipe.id = recipe?.id ?? 0
        newCachedRecipe.cheap = recipe?.cheap ?? false
        newCachedRecipe.spoonacularScore = recipe?.spoonacularScore ?? 0
        newCachedRecipe.servings = recipe?.servings ?? 0
        newCachedRecipe.title = recipe?.title ?? ""
        newCachedRecipe.readyInMinutes = recipe?.readyInMinutes ?? 0
        newCachedRecipe.image = recipe?.image ?? ""
        newCachedRecipe.summary = recipe?.summary ?? ""
        newCachedRecipe.pricePerServing = recipe?.pricePerServing ?? 0
        
        guard let ingredients = recipe?.extendedIngredients else {return}
        for ingredient in ingredients {
            let newCachedIngredient = CachedIngredient()
            newCachedIngredient.id = ingredient.id ?? 0
            newCachedIngredient.aisle = ingredient.aisle ?? ""
            newCachedIngredient.consistency = ingredient.consistency ?? ""
            newCachedIngredient.original = ingredient.original ?? ""
            newCachedIngredient.amount = ingredient.amount ?? 0
            newCachedRecipe.extendedIngredients.append(newCachedIngredient)
        }
        
        try! realm.write {
            realm.add(newCachedRecipe)
        }
        
        sender.setImage(UIImage(named: "starFilled"), for: .normal)
        
    }
    
}
