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
import paper_onboarding

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataProviderDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataProvider: DataProvider?
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    var isModalVC = false
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        filteredRecipes = recipes
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        dataProvider = DataProvider()
        dataProvider?.delegate = self
        if isModalVC {
            recipes = []
            filteredRecipes = []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            guard let category = selectedCategory else {return}
            dataProvider?.searchByIngredient(name: category)
        } else {
            dataProvider?.fetchData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isModalVC {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        } else {
            title = selectedCategory
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isModalVC {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeTableViewCell
        
        if let urlString = filteredRecipes[indexPath.row].image {
            cell.recipeImageView.sd_setImage(with: URL(string: urlString))
        }
        cell.recipeTitle.text = filteredRecipes[indexPath.row].title
        cell.timeDurationLabel.text = String(filteredRecipes[indexPath.row].readyInMinutes ?? 0) + " min"
        cell.ingredientsLabel.text = String(filteredRecipes[indexPath.row].extendedIngredients?.count ?? 0) + " ingredients"
        let isCheap = filteredRecipes[indexPath.row].cheap
        
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
        let recipe = filteredRecipes[indexPath.row]
        let destination = segue.destination as? DetailViewController
        destination?.recipe = recipe
    }

    func getRecipes(recipes: [Recipe]) {
        self.recipes = recipes
        filteredRecipes = recipes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText == " " {
            filteredRecipes = recipes
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredRecipes = recipes
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else {return}
        if searchQuery != "" || searchQuery != " " {
            dataProvider?.searchByIngredient(name: searchQuery)
        } else {
            filteredRecipes = recipes
            tableView.reloadData()
        }
    }
    
    func getSearch(results: [Recipe]) {
        filteredRecipes = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
