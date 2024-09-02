//
//  HomeViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    private var categories: [String] = []
    private var recipes: [RecipeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecipesCollectionView()
        setupCategoriesCollectionViews()
        getCategories()
        getRecipes()
        
    }
    
    //MARK: - Gestione Collections
    private func setupCategoriesCollectionViews(){
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: CategoriesCollectionViewCell.reusableIdentifier)
        categoriesCollectionView.tag = 0
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        categoriesCollectionView.showsVerticalScrollIndicator = false
        categoriesCollectionView.allowsMultipleSelection = false
        categoriesCollectionView.allowsSelection = true
        
        if let layout = categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        }
        
    }
    
    private func setupRecipesCollectionView(){
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.tag = 1
        
        recipesCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: RecipeCollectionViewCell.reusableIdentifier)
        
        recipesCollectionView.showsHorizontalScrollIndicator = false
        recipesCollectionView.showsVerticalScrollIndicator = false
        recipesCollectionView.allowsMultipleSelection = true
        recipesCollectionView.allowsSelection = true
        
        recipesCollectionView.collectionViewLayout = generateLottiCollectionLayout()
    }
    
    private func generateLottiCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalWidth(7/10))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return categories.count
        }else{
            return recipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case 0:
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reusableIdentifier, for: indexPath) as! CategoriesCollectionViewCell
            cell.label.text = categories[indexPath.item]
            return cell
        case 1:
            if let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reusableIdentifier, for: indexPath) as? RecipeCollectionViewCell{
                
                
                cell.title.text = recipes[indexPath.item].title
                cell.imageView.image = recipes[indexPath.item].image
                
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    
    //MARK: - Network Methods

    private func getCategories(){
        //TODO: chiamata API
        categories = ["Antipasto", "Primo", "Secondo", "Senza glutine", "Dessert", "Salsa", "Etnico", "Healthy", "Altro", "Contorno"]
    }
    
    private func getRecipes(){
        //TODO: chiamata API
        
        recipes = [
            RecipeModel(id: 0, title: "Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categoria: "Primo", dataId: 0, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 1, title: "Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categoria: "Primo", dataId: 1, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 2,  title: "Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categoria: "Contorno", dataId: 2, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 3, title: "Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categoria: "Antipasto", dataId: 3, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 4, title: "Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categoria: "Primo", dataId: 4, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 5, title: "Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categoria: "Primo", dataId: 5, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 0, title: "Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categoria: "Primo", dataId: 0, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 1, title: "Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categoria: "Primo", dataId: 1, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 2,  title: "Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categoria: "Contorno", dataId: 2, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 3, title: "Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categoria: "Antipasto", dataId: 3, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 4, title: "Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categoria: "Primo", dataId: 4, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 5, title: "Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categoria: "Primo", dataId: 5, recipePostingDate: "2024-09-02")
        ]
    }
    
    
    
}
