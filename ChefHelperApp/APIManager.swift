//
//  APIManager.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import Foundation
import Alamofire

/// Manger dei servizi di chiamate al server
class APIManager {
    static let shared = APIManager()
    
    /// Configurazione (custom) del session manager
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        let networkLogger = NetworkLogger()
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
    
    
    /// Funzione che fa la chiamata API e accetta parametro generico
    /// - Parameters:
    ///   - route: inidirizzo della chiamata composta dell?enumeratore ``Router``
    ///   - responseType: tipo del parametro generico T
    ///   - completion: handler che permette di gestire la risposta delcserver .success .failure
    func APIcall<T:Codable>(route: Router,
                            responseType: T.Type,
                            completion : @escaping (T?,Error?)->Void){
        
        sessionManager.request(route).responseDecodable(of: responseType.self){ response in
            
            
            switch response.result{
            case .success:
                guard let data = response.value else { return }
                completion(data, nil)
                
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
        
    }
    
}
