//
//  IngredientTableViewCell.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 26/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import RealmSwift

protocol IngredientCellDelegate {
    func get(ingredient: String)
}

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var tempIngredient: String? {
        didSet {
            guard let ingredientName = tempIngredient else {return}
            let results = realm.objects(IngredientToBuy.self)
            for result in results {
                if result.name == ingredientName {
                    addButton.setImage(UIImage(named: "addedToCart"), for: .normal)
                    break
                }
            }
        }
    }
    
    var delegate: IngredientCellDelegate?
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let ingredientName = ingredientLabel.text else {return}
        
        let results = realm.objects(IngredientToBuy.self)
        for result in results {
            if result.name == ingredientName {
                try! realm.write {
                    realm.delete(result)
                }
                sender.setImage(UIImage(named: "addToCart"), for: .normal)
                return
            }
        }
        try! realm.write {
            let newIngredient = IngredientToBuy()
            newIngredient.name = ingredientName
            newIngredient.tag = 100
            realm.add(newIngredient)
        }
        sender.setImage(UIImage(named: "addedToCart"), for: .normal)
    }
}


