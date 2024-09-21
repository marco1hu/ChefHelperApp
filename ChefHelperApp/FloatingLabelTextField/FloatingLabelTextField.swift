//
//  FloatingLabelTextField.swift
// 
//
//  Created by IFTS40 on 25/07/24.
//

import UIKit

/// Componente customizzabile class di UIVIew. Textfield con una floating label. Puoi aggiungere un'incona a sinistra e il bottone di input sicuro per le password a destra.
@IBDesignable
final class FloatingLabelTextField: UIView {
    /// Left icon image name (.png)
    @IBInspectable var leftImage: String = "" {
        didSet{
            if leftImage != oldValue {
                containerView.leftImage = leftImage
            }
        }
    }
    
    /// Nome dell'immagine dell'icona di destra quando l'input sicuro della password è attivo(.png)
    @IBInspectable var rightImageOn: String = "" {
        didSet{
            if rightImageOn != oldValue {
                containerView.rightImageOn = rightImageOn
            }
        }
    }
    
    /// Nome dell'immagine dell'icona di destra quando l'input sicuro della password è disattivato(.png)
    @IBInspectable var rightImageOff = "" {
        didSet{
            if rightImageOff != oldValue {
                containerView.rightImageOff = rightImageOff
            }
        }
    }
    
    /// Colore del bordo della textfield
    /// Default:
    /// var borderColor:UIColor = UIColor.black
    @IBInspectable var borderColor:UIColor = UIColor.black {
        didSet {
            if borderColor != oldValue {
                containerView.textfieldBorderColor = borderColor.cgColor
            }
        }
    }
    
    /// Larghezza bordo textfield
    /// Default:
    /// var borderWidth: CGFloat = 1
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            if borderWidth != oldValue {
                containerView.textfieldLineWidth = borderWidth
            }
        }
    }
    
    /// Textfield corner radius
    /// Default:
    /// var cornerRadius: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            if cornerRadius != oldValue {
                containerView.textfieldCornerRadius = cornerRadius
            }
        }
    }
    
    /// Testo placeholder della textfield
    /// Default:
    /// var placeholder: String = "Placeholder"
    @IBInspectable var placeholder: String = "Placeholder" {
        didSet{
            if placeholder != oldValue{
                containerView.placeholder = placeholder
            }
        }
    }
    
    /// Font del testo del placeholder e del textfield
    /// Default:
    /// var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    @IBInspectable var textFont: UIFont = UIFont.systemFont(ofSize: 15){
        didSet{
            if textFont != oldValue{
                containerView.textFont = textFont
                containerView.textfield.font = textFont
            }
        }
    }
    
    
    /// Colore del testo del placeholder
    @IBInspectable var placeholderTextColor: UIColor = UIColor.gray {
        didSet{
            if placeholderTextColor != oldValue{
                containerView.placeholderColor = placeholderTextColor
            }
        }
    }
    
    /// Font del floating label
    @IBInspectable var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet{
            if floatingLabelFont != oldValue{
                containerView.floatingLabelFont = floatingLabelFont
            }
        }
    }
    
    /// Colore floating label
    @IBInspectable var floatingLabelColor: UIColor = .black {
        didSet{
            if floatingLabelColor != oldValue{
                containerView.floatingLabelTextColor = floatingLabelColor
            }
        }
    }
    
    /// Valore traslazione orizzontale della posizione finale del floating label
    @IBInspectable var floatingLabelXtranslation: CGFloat = 0 {
        didSet{
            if floatingLabelXtranslation != oldValue{
                containerView.floatingLabelXtranslation = floatingLabelXtranslation
            }
        }
    }
    
    /// Valore traslazione verticale della posizione finale del floating label
    @IBInspectable var floatingLabelYtranslation: CGFloat = 0 {
        didSet{
            if floatingLabelYtranslation != oldValue{
                containerView.floatingLabelYtranslation = floatingLabelYtranslation
            }
        }
    }
    
    /// Tempo animazione floating label
    /// Default:
    /// var animationTime: Double = 0.2
    @IBInspectable var animationTime: Double = 0.2 {
        didSet{
            if animationTime != oldValue{
                containerView.animationTime = animationTime
            }
        }
    }
    
    /// Tag identificativo del textfield
    @IBInspectable var textfieldTag: Int = 0{
        didSet{
            if textfieldTag != oldValue{
                containerView.textfield.tag = textfieldTag
            }
        }
    }
    
    /// Testo nel textfield
    var text: String? {
        get {
            return containerView.textfield.text
        }
    }
    
    /// TextField Delegate
    var delegate: UITextFieldDelegate? {
        didSet{
            containerView.textfield.delegate = delegate
        }
    }
    
    /// BackgroundColor
    var FLTextFieldBackgroundColor: UIColor?{
        didSet{
            self.backgroundColor = FLTextFieldBackgroundColor
            self.containerView.backgroundColor = FLTextFieldBackgroundColor
            self.containerView.floatingLabel.backgroundColor = FLTextFieldBackgroundColor
        }
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var containerView: FloatingLabelTextFieldContainerView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FloatingLabelTextField", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        containerView.floatingLabelTextColor = .black
        contentView.backgroundColor = .clear
        
        self.bringSubviewToFront(containerView)
        
    }
    
    public func showError(color: UIColor = UIColor.red){
        self.containerView.changeColorTextFieldFromOriginal = true
        self.containerView.reDrawBorder(color: color)
    }
    
    public func showCorrect(color: UIColor = UIColor.green){
        self.containerView.changeColorTextFieldFromOriginal = true
        self.containerView.reDrawBorder(color: color)
    }
    
    public func reDrawTextField(){
        self.containerView.changeColorTextFieldFromOriginal = false
        self.containerView.reDrawBorder()
    }
    
    public func deleteAllText(){
        self.containerView.textfield.text  = ""
        self.containerView.resetfLabel()
    }
    
    
}
