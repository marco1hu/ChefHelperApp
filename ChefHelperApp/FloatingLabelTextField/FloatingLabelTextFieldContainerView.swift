//
//  FloatingLabelTextFieldContainerView.swift
// 
//
//  Created by IFTS40 on 25/07/24.
//

import UIKit

/// UIView annidata nella FloatingLabelTextField che contine la UITextfield e implementa le modifiche passate dalla superview
class FloatingLabelTextFieldContainerView: UIView, UITextFieldDelegate {
    
    /// Nome stringa dell'immagine (icona) che sta nella imageView a sinistra della textfield
    var leftImage = "" {
        didSet {
            if leftImage != oldValue {
                leftView.image = leftImage
                self.textfield.leftViewMode = .always
                
                NSLayoutConstraint.deactivate(self.fLabelInitialConstraints)
                
                fLabelInitialConstraints = [
                    floatingLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: leftView.frame.size.width-5),
                    floatingLabel.centerYAnchor.constraint(equalTo: textfield.centerYAnchor)
                ]
                
                fLabelFinalConstraints  = [
                    floatingLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: leftView.frame.size.width + floatingLabelXtranslation),
                    floatingLabel.centerYAnchor.constraint(equalTo: self.topAnchor)
                ]
                
                textfieldLeadingConstraint.constant = 8
                NSLayoutConstraint.activate(self.fLabelInitialConstraints)
                self.layoutIfNeeded()
            }
        }
        
    }
    /// Nome stringa dell'immagine (icona) che sta nel UIbutton a destra della textfield quando è il bottone non è selezionato
    var rightImageOn = "" {
        didSet {
            if rightImageOn != oldValue {
                rightView.imageOn = rightImageOn
                self.textfield.rightViewMode = .always
                textfield.isSecureTextEntry = true
                rightView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }
    }
    
    /// Nome stringa dell'immagine (icona) che sta nel UIbutton a destra della textfield quando è il bottone è selezionato
    var rightImageOff = "" {
        didSet {
            if rightImageOff != oldValue {
                rightView.imageOff = rightImageOff
                self.textfield.rightViewMode = .always
                textfield.isSecureTextEntry = true
                rightView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }
    }
    
    var textfieldBorderColor: CGColor = UIColor.black.cgColor
    var textfieldLineWidth: CGFloat = 1
    var textfieldCornerRadius: CGFloat = 0.0
    var animationTime: Double = 0.2
    
    
    var placeholder: String = "Placeholder" {
        didSet{
            floatingLabel.text = " \(placeholder) "
            
        }
    }
    
    var placeholderColor: UIColor = UIColor.gray
    var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 15){
        didSet {
            if floatingLabelFont != oldValue{
                floatingLabel.font = floatingLabelFont
            }
        }
    }
    
    var floatingLabelTextColor: UIColor = .black{
        didSet{
            if floatingLabelTextColor != oldValue{
                floatingLabel.textColor = floatingLabelTextColor
            }
        }
    }
    
    var floatingLabelXtranslation: CGFloat = 0{
        didSet{
            NSLayoutConstraint.deactivate(self.fLabelInitialConstraints)
            
            fLabelFinalConstraints  = [
                floatingLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: leftView.frame.size.width + floatingLabelXtranslation),
                floatingLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: floatingLabelYtranslation)
            ]
            NSLayoutConstraint.activate(self.fLabelInitialConstraints)
            self.layoutIfNeeded()
        }
    }
    
    var floatingLabelYtranslation: CGFloat = 0 {
        didSet{
            NSLayoutConstraint.deactivate(self.fLabelInitialConstraints)
            
            fLabelFinalConstraints  = [
                floatingLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: leftView.frame.size.width + floatingLabelXtranslation),
                floatingLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: floatingLabelYtranslation)
            ]
            NSLayoutConstraint.activate(self.fLabelInitialConstraints)
            self.layoutIfNeeded()
        }
    }
    
    var newBorderColor: UIColor = UIColor.red
    
    private var fLabelInitialConstraints: [NSLayoutConstraint] = []
    private var fLabelFinalConstraints:[NSLayoutConstraint] = []
    
    private var leftView: TextFieldLeftView!
    private var rightView: TextFieldRightView!
    
    
    private var floatingLabel = UILabel()
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textfieldLeadingConstraint: NSLayoutConstraint!
    
    
    
    var changeColorTextFieldFromOriginal = false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setAllowsAntialiasing(true)
        context.setShouldAntialias(true)
        
        context.setStrokeColor(textfieldBorderColor)
        context.setLineWidth(textfieldLineWidth)
        
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: textfieldLineWidth / 2, dy: textfieldLineWidth / 2), cornerRadius: textfieldCornerRadius)
        
        path.lineWidth = textfieldLineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        if changeColorTextFieldFromOriginal {
            newBorderColor.setStroke()
        }
        path.stroke()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FloatingLabelTextFieldContainerView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        
        textFieldSetup()
        floatingLabelSetup()
        NSLayoutConstraint.activate(fLabelInitialConstraints)
        self.layoutIfNeeded()
        
    }
    
    func reDrawBorder(color: UIColor = UIColor.red){
        self.newBorderColor = color
        self.setNeedsDisplay()
    }
    
    private func textFieldSetup(){
        
        textfield.backgroundColor = .clear
        textfield.placeholder = ""
        leftView = TextFieldLeftView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        textfield.leftView = leftView
        rightView = TextFieldRightView(frame:  CGRect(x: 0, y: 0, width: 36, height: 36))
        textfield.rightView = rightView
        textfield.isSecureTextEntry = false
        textfield.font = textFont
        
        
        textfield.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        textfield.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
        
    }
    
    
    private func floatingLabelSetup(){
        floatingLabel.text = " \(placeholder) "
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        floatingLabel.textColor = placeholderColor
        floatingLabel.font = floatingLabelFont
        
        floatingLabel.layer.backgroundColor = UIColor.white.cgColor
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingLabel.clipsToBounds = true
        
        if leftImage == "" {
            fLabelInitialConstraints = [
                floatingLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: -3),
                floatingLabel.centerYAnchor.constraint(equalTo: textfield.centerYAnchor)
            ]
            
            fLabelFinalConstraints  = [
                floatingLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor),
                floatingLabel.centerYAnchor.constraint(equalTo: self.topAnchor)
            ]
            
        }
        self.addSubview(floatingLabel)
        self.bringSubviewToFront(floatingLabel)

    }
    
    @objc private func addFloatingLabel() {
        if textfield.text == "" {
                        
            NSLayoutConstraint.activate(fLabelInitialConstraints)
            self.layoutIfNeeded()
            
            UIView.animate(withDuration: animationTime, animations: {
                self.floatingLabel.textColor = self.floatingLabelTextColor
                NSLayoutConstraint.deactivate(self.fLabelInitialConstraints)
                NSLayoutConstraint.activate(self.fLabelFinalConstraints)
                self.layoutIfNeeded()
            })
            

        }
    }
    
    
    @objc private func removeFloatingLabel() {
        if textfield.text == "" {
            NSLayoutConstraint.activate(fLabelFinalConstraints)
            self.layoutIfNeeded()
            
            UIView.animate(withDuration: animationTime, animations: {
                
                self.floatingLabel.textColor = self.placeholderColor
                
                NSLayoutConstraint.deactivate(self.fLabelFinalConstraints)
                NSLayoutConstraint.activate(self.fLabelInitialConstraints)
                self.layoutIfNeeded()
            })
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        textfield.isSecureTextEntry = !textfield.isSecureTextEntry
    }
}
