//
//  FavouritesViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 27/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var recipes: [CachedRecipe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        recipes = Array(realm.objects(CachedRecipe.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = Array(realm.objects(CachedRecipe.self))
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteRecipeCell", for: indexPath) as! RecipeTableViewCell
        
        if let urlString = recipes?[indexPath.row].image {
            cell.recipeImageView.sd_setImage(with: URL(string: urlString))
        }
        cell.recipeTitle.text = recipes?[indexPath.row].title
        cell.timeDurationLabel.text = String(recipes?[indexPath.row].readyInMinutes ?? 0) + " min"
        cell.ingredientsLabel.text = String(recipes?[indexPath.row].extendedIngredients.count ?? 0) + " ingredients"
        if let isCheap = recipes?[indexPath.row].cheap {
            if isCheap {
                cell.priceLabel.text = "$-$$"
            } else {
                cell.priceLabel.text = "$$-$$$"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailsFromFavourite", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        guard let recipe = recipes?[indexPath.row] else {return}
        let destination = segue.destination as? DetailViewController
        destination?.recipe = ModelTransferHelper.fromCachedToRecipe(recipe)
    }
}
