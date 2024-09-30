//
//  Router.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import Foundation
import Alamofire


/// Routing dei request utilizzabili
enum Router: URLRequestConvertible{
    case allRecipes
    
    func asURLRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: "")!)
    }
    
}
