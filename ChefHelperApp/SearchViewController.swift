//
//  SearchViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var diffcultyBar: DifficultyLevelComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diffcultyBar.levelDifficulty = 4
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
