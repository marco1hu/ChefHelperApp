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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag{
        case 0:
            print(categories[indexPath.item])
            
            let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        
            cell.isSelectedCell = !cell.isSelectedCell
            
            cell.toggleSelected()
            
            //TODO: Logica filtri per categori<
            
            
        case 1:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "recipeDetails") as? DetailRecipeViewController else { return }
            
            
            getRecipesDataById(id: recipes[indexPath.item].dataId){ data in
                
                if let data = data {
                    vc.recipeData = data
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.present(Utilities.shared.alertErrorGeneral(error: "Errore interno"), animated: true)
                }
            }
            
        default:
            return
        }
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
    
    private func getRecipesDataById(id: Int, completion: @escaping (RecipeData?)->Void){
        //TODO: chiamata API
        let dataDummy = RecipeData(id: 0, title: "Spaghetti Cacio e Pepe", subtitle: "Dalla tradizione", portions: 3, difficulty: "Easy", ingredients: ["Formaggio Cacio", "Pepe", "Pasta"], 
                                   steps: ["Prendi pentolino metti acqua e sale fai bollire",
                                          "Taglia il formaggio",
                                          "Macina pepe",
                                          "Prepara ry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more rece",
                                          "ry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more rece",
                                          "ry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more rece"],
                                   author: "N.N.")
        completion(dataDummy)
    }
    
    
    
}
