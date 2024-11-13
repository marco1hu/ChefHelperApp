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
    
    
    var recipes: [RecipeModel] = []{
        didSet {
            print("recipes.count: \(recipes.count)")
            if recipes.count == 179 {
                DispatchQueue.main.async {
                    self.reload()
                }
            }
        }
    }
    
    private var categories: [String] = []{
        didSet{
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
            }
        }
    }
    private var allRecipes: [RecipeModel] = []
    
    
    private var shownRecipes: [RecipeModel] = []{
        didSet {
            recipesCollectionView.reloadData()
        }
    }
    
    private var selectedCategory: String? = nil{
        didSet{
            if selectedCategory != nil {
                
                shownRecipes = allRecipes.filter({ recipe in
                    if let recipeCategory = recipe.category, recipeCategory.contains(selectedCategory!){
                        return true
                    }else{
                        return false
                    }
                })
            }else{
                shownRecipes = allRecipes
            }
        }
        
    }
    private let refreshControl = UIRefreshControl()
    private var categoriesData: [String] = []{
        didSet{
            if categoriesData.count == 4 {
                categories = categoriesData
            }
        }
    }
    
    private var detailRecipe: [RecipeData] = []
    
    
    //MARK: - App Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicatorManager.shared.showIndicator(on: self.view)
        
        self.loadRecipes {
            APIManager.shared.dataList = self.recipes
            self.getRecipes()
        }
        
        setupRecipesCollectionView()
        setupCategoriesCollectionViews()
        
        setupUI()
        self.getCategories {
            APIManager.shared.categorieList = self.categoriesData
        }
        
    }

    //MARK: - Setup UI Methods
    private func setupUI(){
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Indietro", style: .plain, target: nil, action: nil)
    }
    
    
    
    //MARK: - Gestione e Setup Collections
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
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            
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
        
        recipesCollectionView.collectionViewLayout = generateCardCollectionLayout()
        

        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        recipesCollectionView.addSubview(refreshControl)
    }
    
    
    private func generateCardCollectionLayout() -> UICollectionViewLayout {
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
    
    
    
    //MARK: - Collection Delegates
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
            let cell = categoriesCollectionView
                .dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reusableIdentifier,
                                     for: indexPath) as! CategoriesCollectionViewCell
            
            let category = categories[indexPath.item]
            
            cell.label.text = category

            if selectedCategory == category {
                cell.isSelectedCell = true
            } else {
                cell.isSelectedCell = false

            }
            return cell
            
        case 1:
            if let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reusableIdentifier, for: indexPath) as? RecipeCollectionViewCell {
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
            
            if selectedCategory == cell.label.text! {
                selectedCategory = nil
                categoriesCollectionView.reloadData()

            }else{
                selectedCategory = cell.label.text!
                categoriesCollectionView.reloadData()
            }
           
            
            
            
        case 1:
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailRecipe") as? DetailRecipeViewController else { return }
            getRecipesDataById(id: shownRecipes[indexPath.item].dataId!) { data in
                if let data = data {
                    vc.recipeData = data
                    vc.categorie = self.shownRecipes[indexPath.item].category
                    vc.image = self.shownRecipes[indexPath.item].image
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }
            }
            
            
        default:
            return
        }
    }
    
    
    //MARK: - Network Methods
    
    func loadRecipes(completion: @escaping () -> Void) {
        
        let ref = Database.database().reference()
        
        ref.child("ricettario").queryOrdered(byChild: "id").observe(.childAdded, with: { (snap) in
            if let dict = snap.value as? [String: AnyObject]{
                let title = dict["title"] as! String
                
                let category = dict["category"] as! String
                let difficulty = dict["difficulty"] as! Int
                let habits = dict["habits"] as! String
                let id = dict["id"] as! Int
                let ingredients = dict["ingredients"] as! [String]
                let portions = dict["portions"] as! Int
                let steps = dict["steps"] as! [String]
                let time = dict["time"] as! String
                let year_period = dict["year_period"] as! String
                let dataId = dict["id"] as! Int
                let imageURL = dict["image"] as? String
                
                if let url = URL(string: imageURL!) {
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print("Errore nel download dell'immagine: \(error)")
                            return
                        }
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                
                                print(image)
                                self.recipes.append(RecipeModel(id: id,
                                                                title: title,
                                                                portions: portions,
                                                                difficulty: difficulty,
                                                                ingredients: ingredients,
                                                                steps: steps,
                                                                image: image,
                                                                category: [category],
                                                                habits: habits,
                                                                time: time,
                                                                year_period: year_period,
                                                                dataId: dataId))
                            }
                        }
                        
                    }.resume()
                }
            }
        })
        completion()
    }
    
    
    
    
    private func getCategories(completion: @escaping () -> Void){
        let ref = Database.database().reference()
        
        ref.child("categorie").observe(.childAdded, with: { snap in
            guard let value = snap.value else { return }
            if let cat = value as? String{
                self.categoriesData.append(cat)
                print(self.categoriesData)
            }
            completion()
        })
        
    }
    
    
    private func getRecipes(){
        self.allRecipes = APIManager.shared.dataList.shuffled()
        shownRecipes = allRecipes
    }
    
    
    //MARK: - Helper Functions
    @objc func dataListUpdated() {
        getRecipes()
        recipesCollectionView.reloadData()
    }
    
    private func getRecipesDataById(id: Int, completion: @escaping (RecipeData?)->Void){
        //TODO: chiamata API
        let ref = Database.database().reference()
        
        ref.child("ricettario").queryOrdered(byChild: "id").queryEqual(toValue: id).observeSingleEvent(of: .value, with: { (snap) in
            for child in snap.children.allObjects as! [DataSnapshot] {
                if let data = child.value as? [String: AnyObject]{
                    let title = data["title"] as! String
                    let difficulty = data["difficulty"] as! Int
                    let id = data["id"] as! Int
                    let ingredients = data["ingredients"] as! [String]
                    let portions = data["portions"] as! Int
                    let steps = data["steps"] as! [String]
                    
                    
                    completion(RecipeData(id: id, title: title, portions: portions, difficulty: difficulty, ingredients: ingredients, steps: steps))
                }
            }
            
        })
        
    }
    
    @objc private func refreshTableData() {
        
        self.loadRecipes{
            APIManager.shared.dataList = []
            self.recipes = APIManager.shared.dataList
            self.selectedCategory = nil
            self.recipesCollectionView.reloadData()
        }
    }
    
    
    @objc private func reload(){
        APIManager.shared.dataList = recipes
        ActivityIndicatorManager.shared.hideIndicator()
        self.refreshControl.endRefreshing()
        getRecipes()
        self.recipesCollectionView.reloadData()
    }
    
    
    
    @objc private func categorieListUpdated(){
        self.categories =  APIManager.shared.categorieList
        
    }
    
    
}

