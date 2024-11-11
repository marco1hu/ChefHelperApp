//
//  Utilities.swift
//  
//
//  Created by IFTS40 on 02/08/24.
//

import Foundation
import UIKit

/// Classe utility che implementa funzioni generiche usate in diverse parti del codice
class Utilities {
    static let shared = Utilities()
    private init() {}
    
    /// F che crea un alert di errore
    /// - Parameter error: messaggio nell'alert d'errore
    /// - Returns: ritorna un alert da presentare
    func alertErrorGeneral(error: String) -> UIAlertController {
        let alert = UIAlertController(title: "Errore", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
    /// Valida emai: torna truel se è  scriita nel formato di una mail altrimenti false
    /// - Parameter email: email da validare
    /// - Returns: risposta vera o falsa
    func isValidEmail(_ email: String) -> Bool {
        if email.isEmpty {
            return false
        }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    
    func isValidPassword(_ password: String) -> Bool {
        if password.isEmpty {
            return false
        }
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    /// Animazione di errore: fa muovere destra e  sinistra per 4 volte simulando una vibrazione
    /// - Parameter view: la view da animare 
    func performViewErrorAnimation(view: UIView){
        DispatchQueue.main.async {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.03
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
            
            view.layer.add(animation, forKey: "position")
        }
    }
}
