//
//  Reachability.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import Foundation
import Alamofire
import UIKit

/// Classe che controlla se si reisce a raggiungere  internet e gestisce i messagi d'errore di connessione. Da istanziare al lancio dell'app
class NetworkReachability {
    static let shared = NetworkReachability()
    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    
    let offlineAlertController: UIAlertController = {
        UIAlertController(title: "Non c'è connessione", message: "Per favore connettiti alla rete e riprova", preferredStyle: .alert)
    }()
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular):
                self.dismissOfflineAlert()
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            }
        }
    }
    
    
    
    func showOfflineAlert() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.present(offlineAlertController, animated: true, completion: nil)
        }
    }
    
    func dismissOfflineAlert() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}
