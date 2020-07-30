//
//  ShoppingViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 27/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var shoppingList = [IngredientToBuy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping"
        tableView.dataSource = self
        tableView.delegate = self
        
        shoppingList = Array(realm.objects(IngredientToBuy.self))
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shoppingList = Array(realm.objects(IngredientToBuy.self))
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row].name
        return cell
    }

    
}
