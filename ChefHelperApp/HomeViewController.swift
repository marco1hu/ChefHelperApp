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
        setupUI()
        
    }
    
    private func setupUI(){
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Indietro", style: .plain, target: nil, action: nil)
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
        recipesCollectionView.allowsMultipleSelection = false
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
            
            let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        
            cell.isSelectedCell = !cell.isSelectedCell
            
            cell.toggleSelected()
            
            //TODO: Logica filtri per categori<
            
            
        case 1:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailRecipe") as? DetailRecipeViewController else { return }
            
            
            getRecipesDataById(id: recipes[indexPath.item].dataId){ data in
                
                if let data = data {
                    vc.recipeData = data
                    vc.image = self.recipes[indexPath.item].image
                    vc.categoria = self.recipes[indexPath.item].categoria
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.present(Utilities.shared.alertErrorGeneral(error: "Errore interno"), animated: true)
                }
            }
            
        default:
            return
        }
    }
    
    
    
    
    private func handleFilterByCategories(){
        //TODO: Logica filtri per categorie
        
    }
    
    
    
    //MARK: - Network Methods

    private func getCategories(){
        //TODO: chiamata API
        categories = ["Antipasto", "Primo", "Secondo", "Senza glutine", "Dessert", "Salsa", "Etnico", "Healthy", "Altro", "Contorno"]
    }
    
    private func getRecipes(){
        //TODO: chiamata API
        
        let allRecipes = [
            RecipeModel(id: 0, title: "Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categoria: "Primo", dataId: 0, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 1, title: "Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categoria: "Primo", dataId: 1, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 2,  title: "Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categoria: "Contorno", dataId: 2, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 3, title: "Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categoria: "Etnico", dataId: 3, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 4, title: "Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categoria: "Primo", dataId: 4, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 5, title: "Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categoria: "Primo", dataId: 5, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 6, title: "1Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categoria: "Primo", dataId: 0, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 7, title: "1Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categoria: "Primo", dataId: 1, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 8,  title: "1Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categoria: "Contorno", dataId: 2, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 9, title: "1Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categoria: "Antipasto", dataId: 3, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 10, title: "1Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categoria: "Primo", dataId: 4, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 11, title: "1Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categoria: "Primo", dataId: 5, recipePostingDate: "2024-09-02"),RecipeModel(id: 0, title: "Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categoria: "Primo", dataId: 0, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 12, title: "2Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categoria: "Primo", dataId: 1, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 13,  title: "2Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categoria: "Contorno", dataId: 2, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 14, title: "2Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categoria: "Etnico", dataId: 3, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 15, title: "2Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categoria: "Primo", dataId: 4, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 16, title: "2Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categoria: "Primo", dataId: 5, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 17, title: "2Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categoria: "Primo", dataId: 0, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 18, title: "3Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categoria: "Primo", dataId: 1, recipePostingDate: "2024-09-02" ),
            RecipeModel(id: 19,  title: "3Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categoria: "Contorno", dataId: 2, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 20, title: "3Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categoria: "Antipasto", dataId: 3, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 21, title: "3Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categoria: "Primo", dataId: 4, recipePostingDate: "2024-09-02"),
            RecipeModel(id: 22, title: "3Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categoria: "Primo", dataId: 5, recipePostingDate: "2024-09-02")
        ]
        recipes = allRecipes
    }
    
    private func getRecipesDataById(id: Int, completion: @escaping (RecipeData?)->Void){
        //TODO: chiamata API
        let dataDummy = RecipeData(id: 0, title: "Spaghetti Cacio e Pepe", subtitle: "Dalla tradizione", portions: 3, difficulty: 3, ingredients: ["Formaggio Cacio", "Pepe", "Pasta"],
                                   steps: ["Prendi pentolino metti acqua e sale fai bollire",
                                          "Taglia il formaggio",
                                          "Macina pepe",
                                          "Prepara ry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more rece",
                                          "ry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more rece",
                                          "ry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more rece"],
                                   author: "Cracco")
        completion(dataDummy)
    }
    
    
    
}
