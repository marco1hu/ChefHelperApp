//
//  NetworkLogger.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import Foundation
import Alamofire

/// Monitora e registra le richieste e le risposte di rete.
/// Quando una richiesta termina, stampa la descrizione della richiesta; quando viene ricevuta una risposta, tenta di convertire i dati in JSON e, se ci riesce, stampa il JSON risultante.
/// Queste operazioni di logging sono eseguite in modo asincrono per non bloccare il thread principale.
class NetworkLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "com.all-in.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
