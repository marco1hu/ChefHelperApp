//
//  ActivityIndicatorManager.swift
//  ChefHelperApp
//
//  Created by Marco Hu on 08/11/24.
//

import Foundation
import UIKit


/// Classe che gestisce la "rotella" di caricamento
public class ActivityIndicatorManager {
    
    public static let shared = ActivityIndicatorManager()
    
    private var activityIndicator: UIActivityIndicatorView?
    private var overlayView: UIView?
    
    private init() {}
    
    /// Funzione che mostra una "rotella" di caricamento
    /// - Parameter view: view dove mostrare la "rotella" di caricamento, (la rotella viene aggiunta a qusta view)
    public func showIndicator(on view: UIView) {
        if overlayView == nil, activityIndicator == nil {
            
            let overlay = UIView(frame: view.bounds)
            overlay.backgroundColor = UIColor(white: 0, alpha: 0.2)
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = overlay.center
            indicator.startAnimating()
            
            overlay.addSubview(indicator)
            view.addSubview(overlay)
            
            overlayView = overlay
            activityIndicator = indicator
        }
    }
    
    /// Funzione che nasconde la "rotella" caricamento
     public func hideIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        overlayView?.removeFromSuperview()
        
        activityIndicator = nil
        overlayView = nil
    }
}
