//
//  CategoriesCollectionCell.swift
//
//
//  Created by IFTS40 on 06/08/24.
//

import UIKit

/// Reusable cell di CategoriesCollectionView
class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    static let reusableIdentifier = "categoriesCell"
    private let fontSize: CGFloat = 18
  //  private let height: CGFloat = 30
    var isSelectedCell: Bool = false
    
    public var handleSelection: ((String)->Void)?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    func updateUI(){
        
        if let categoriesDescriptor = UIFontDescriptor(name: "Helvetica Neue", size: fontSize).withSymbolicTraits([.traitBold]) {
            label.font = UIFont(descriptor: categoriesDescriptor, size: fontSize)
        } else {
            label.font = UIFont(name: "Helvetica Neue", size: fontSize)
        }
        
        label.textColor = UIColor.black
        
        
        backView.layer.cornerRadius = 10
        backView.backgroundColor = UIColor.appColor3
        
        
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -10),
            backView.rightAnchor.constraint(equalTo: label.rightAnchor, constant: 10),
    //        backView.heightAnchor.constraint(equalToConstant: height)
            
        ])
        
        
    }
    
    func toggleSelected (){
        DispatchQueue.main.async {
            if self.isSelectedCell {
                self.setSelected()
               
            }else{
                self.setDeselected()
               
            }
            self.handleSelection?(self.label.text!)
        }
    }
    
    func setSelected(){
        backView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.7019607843, blue: 0.5647058824, alpha: 1)
    }
    
    func setDeselected(){
        backView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8671232717, blue: 0.7085848917, alpha: 1)
    }
}
