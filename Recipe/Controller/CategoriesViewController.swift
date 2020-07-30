//
//  CategoriesViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 29/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit

struct Category {
    let imageName: String
    let categoryName: String
}

class CategoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var selectedCategory = ""
    var categories = [Category(imageName: "seafood", categoryName: "Seafood"),
                      Category(imageName: "snacks", categoryName: "Snacks"),
                      Category(imageName: "burgers", categoryName: "Burgers"),
                      Category(imageName: "desserts", categoryName: "Desserts"),
                      Category(imageName: "pizza", categoryName: "Pizza"),
                      Category(imageName: "oriental", categoryName: "Oriental"),
                      Category(imageName: "burgers", categoryName: "Burgers"),
                      Category(imageName: "desserts", categoryName: "Desserts")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CategoryCell")
    }
    
    func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemsInRow: CGFloat = 2
            let lineSpacing: CGFloat = 1
            let interItemSpacing: CGFloat = 1
            
            let width = (collectionView.frame.size.width-(numberOfItemsInRow-1)*interItemSpacing)/numberOfItemsInRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            
        }
    }

}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.imageView.image = UIImage(named: categories[indexPath.row].imageName)
        cell.categoryNameLabel.text = categories[indexPath.row].categoryName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row].categoryName
        performSegue(withIdentifier: "fromCategoriesToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MainViewController
        destination?.isModalVC = true
        destination?.selectedCategory = selectedCategory
        print(selectedCategory)
    }
}
