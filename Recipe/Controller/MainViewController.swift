//
//  ViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 24/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataProviderDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataProvider: DataProvider?
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        dataProvider = DataProvider(delegate: self)
        dataProvider?.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeTableViewCell
        
        if let urlString = recipes[indexPath.row].image {
            cell.recipeImageView.sd_setImage(with: URL(string: urlString))
        }
        cell.recipeTitle.text = recipes[indexPath.row].title
        cell.timeDurationLabel.text = String(recipes[indexPath.row].readyInMinutes ?? 0) + " min"
        cell.ingredientsLabel.text = String(recipes[indexPath.row].extendedIngredients?.count ?? 0) + " ingredients"
        let isCheap = recipes[indexPath.row].cheap
        
        if isCheap! {
            cell.priceLabel.text = "$-$$"
        } else {
            cell.priceLabel.text = "$$-$$$"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let recipe = recipes[indexPath.row]
        let destination = segue.destination as? DetailViewController
        destination?.recipe = recipe
    }

    func getRecipes(recipes: [Recipe]) {
        self.recipes = recipes
        print(recipes.count)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

