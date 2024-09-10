//
//  DetailRecipe2TableViewCell.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 10/09/24.
//

import UIKit

class DetailRecipe2TableViewCell: UITableViewCell {

    @IBOutlet weak var stepTitleLabel: UILabel!
    @IBOutlet weak var stepDescription: UILabel!
    
    static let reusableIdentifier = "detail2Cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup(){
        self.selectionStyle = .none
    }
}
