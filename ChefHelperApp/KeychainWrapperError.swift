//
//  KeychainWrapperError.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import Foundation

/// Struttura per la gestione degli errori del Keychain
struct KeychainWrapperError: Error {
    var message: String?
    var type: KeychainErrorType
    
    enum KeychainErrorType {
        case badData
        case servicesError
        case itemNotFound
        case unableToConvertToString
    }
    
    init(status: OSStatus, type: KeychainErrorType) {
        self.type = type
        if let errorMessage = SecCopyErrorMessageString(status, nil) {
            self.message = String(errorMessage)
        } else {
            self.message = "Status Code: \(status)"
        }
    }
    
    init(type: KeychainErrorType) {
        self.type = type
    }
    
    init(message: String, type: KeychainErrorType) {
        self.message = message
        self.type = type
    }
}
