//
//  HomeViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    private var categories: [String] = []
    private var allRecipes: [RecipeModel] = []
    private var shownRecipes: [RecipeModel] = []
    
    private var selectedCategories: [String] = []
    
    //MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecipesCollectionView()
        setupCategoriesCollectionViews()
        getCategories()
        getRecipes()
        setupUI()
        
    }
    
    
    //MARK: - Setup UI Methods
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
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        }
        
    }
    
    
    //MARK: - Collections Setups and delegates
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
            return shownRecipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case 0:
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reusableIdentifier, for: indexPath) as! CategoriesCollectionViewCell
            let category = categories[indexPath.item]
            
            cell.label.text = category
            cell.handleSelection = handleSelectionCategory
            cell.handleDeselection = handleDeselectionCategory
            
            if selectedCategories.contains(category) {
                cell.setSelected()
            } else {
                cell.setDeselected()
            }
            
            return cell
            
            
        case 1:
            if let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reusableIdentifier, for: indexPath) as? RecipeCollectionViewCell{
                
                
                cell.title.text = shownRecipes[indexPath.item].title
                cell.imageView.image = shownRecipes[indexPath.item].image
                
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
            
            
        case 1:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailRecipe") as? DetailRecipeViewController else { return }
            
            
            getRecipesDataById(id: shownRecipes[indexPath.item].dataId){ data in
                
                if let data = data {
                    vc.recipeData = data
                    vc.image = self.shownRecipes[indexPath.item].image
                    vc.categorie = self.shownRecipes[indexPath.item].categorie
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.present(Utilities.shared.alertErrorGeneral(error: "Errore interno"), animated: true)
                }
            }
            
        default:
            return
        }
    }
    
    
    //MARK: - Filter Logics
    
    private func handleSelectionCategory(category: String) {
        selectedCategories.append(category)
        
        shownRecipes = allRecipes.filter { recipe in
            let recipeCategoriesSet = Set(recipe.categorie)
            let selectedCategoriesSet = Set(selectedCategories)
            
            // Mostra solo le ricette che contengono tutte le categorie selezionate
            return selectedCategoriesSet.isSubset(of: recipeCategoriesSet)
        }
        
        recipesCollectionView.reloadData()
    }

    private func handleDeselectionCategory(category: String) {
        selectedCategories.removeAll { $0 == category }
        
        if selectedCategories.isEmpty {
            shownRecipes = allRecipes
        } else {
            shownRecipes = allRecipes.filter { recipe in
                let recipeCategoriesSet = Set(recipe.categorie)
                let selectedCategoriesSet = Set(selectedCategories)
                
                // Mostra solo le ricette che contengono tutte le categorie selezionate
                return selectedCategoriesSet.isSubset(of: recipeCategoriesSet)
            }
        }
        
        recipesCollectionView.reloadData()
    }

}





extension HomeViewController{
    //MARK: - Network Methods
    
    private func getCategories(){
        //TODO: chiamata API
        
        let ref = Database.database().reference()
        ref.child("antipasti").observe(.childAdded, with: { (snap) in
            if let dict = snap.value as? [String: AnyObject]{
                
                let category = dict["category"] as! String
                
                
                //TODO: filtrare le categorie (al momento solo 1, ma devo finire il db) e fare append in categories
                
            }
        })
        
        
        //    categories = ["Antipasto", "Primo", "Secondo", "Senza glutine", "Dessert", "Salsa", "Etnico", "Healthy", "Altro", "Contorno"]
    }
    
    
    
    
    
    
    
    private func getRecipes(){
        self.allRecipes = APIManager.shared.dataList
        shownRecipes = allRecipes
    }
    
    
    
    
    
    
    
    
    private func getRecipesDataById(id: Int, completion: @escaping (RecipeData?)->Void){
        //TODO: chiamata API
        let dataDummy = RecipeData(id: 0, title: "Spaghetti Cacio e Pepe", subtitle: "Dalla tradizione", portions: 3, difficulty: 2, ingredients: ["Formaggio Cacio", "Pepe", "Pasta"],
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

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
