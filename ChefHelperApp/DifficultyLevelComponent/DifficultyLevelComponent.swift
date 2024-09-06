//
//  DifficultyLevelComponent.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 03/09/24.
//

import UIKit

@IBDesignable
class DifficultyLevelComponent: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rect0: UIView!
    @IBOutlet weak var rect1: UIView!
    @IBOutlet weak var rect2: UIView!
    @IBOutlet weak var rect3: UIView!
    @IBOutlet weak var rect4: UIView!
    
    @IBInspectable var elementWidth: CGFloat = 30 {
        didSet{
            rect0.frame.size.width = CGFloat(elementWidth)
        }
    }
    
    var levelDifficulty: Int?{
        didSet{
            DispatchQueue.main.async {
                self.loadLevel()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        
        Bundle.main.loadNibNamed("DifficultyLevelComponent", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.clipsToBounds = true
        
        rect0.layer.borderColor = UIColor.appColor1.cgColor
        rect0.layer.borderWidth = 0.5
        
        rect1.layer.borderColor = UIColor.appColor1.cgColor
        rect1.layer.borderWidth = 0.5
        
        rect2.layer.borderColor = UIColor.appColor1.cgColor
        rect2.layer.borderWidth = 0.5
        
        rect3.layer.borderColor = UIColor.appColor1.cgColor
        rect3.layer.borderWidth = 0.5
        
        rect4.layer.borderColor = UIColor.appColor1.cgColor
        rect4.layer.borderWidth = 0.5
        
        
    }
    
    
    private func loadLevel(){
        let elementsList = [rect0, rect1, rect2, rect3, rect4]
        if let level = levelDifficulty, level >= 0 && level <= 4 {
            
            for i in 0...level {
                DispatchQueue.main.async {
                    elementsList[i]!.backgroundColor = UIColor.appColor1
                }
                
            }
            
            
        }
    }
    
}
