//
//  KeychainWrapper.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import Foundation

/// Gestore del Keychain, CRUD
class KeychainWrapper {
    
    /// Funzione che salva una stringa nel Keychain
    /// - Parameters:
    ///   - account: Nome account
    ///   - service: Nome servizio
    ///   - password: stringa/passsword da salvare
    func storeGenericPasswordFor(
        account: String,
        service: String,
        password: String
    ) throws {
        
        if password.isEmpty {
            try deleteGenericPasswordFor(
                account: account,
                service: service)
            return
        }
        
        
        guard let passwordData = password.data(using: .utf8) else {
            print("Error converting value to data.")
            throw KeychainWrapperError(type: .badData)
        }
        
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try updateGenericPasswordFor(
                account: account,
                service: service,
                password: password)
            
        default:
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
        
    }
    
    /// Funzione che recupera nel Keychain una password e la restituisce
    /// - Parameters:
    ///   - account: Nome account
    ///   - service: Nome servizio
    /// - Returns: password restituita
    func getGenericPasswordFor(account: String, service: String) throws -> String {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
        
        guard
            let existingItem = item as? [String: Any],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: .utf8)
        else {
            throw KeychainWrapperError(type: .unableToConvertToString)
        }
        
        return value
    }
    
    
    /// Aggiorna una password (sovrascrizione)
    /// - Parameters:
    ///   - account: Nome account
    ///   - service: Nome servizio
    ///   - password: Nuova password
    func updateGenericPasswordFor(
        account: String,
        service: String,
        password: String
    ) throws {
        guard let passwordData = password.data(using: .utf8) else {
            print("Error converting value to data.")
            return
        }
    
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
    
        let attributes: [String: Any] = [
            kSecValueData as String: passwordData
        ]
        
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(
                message: "Matching Item Not Found",
                type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    /// Cancella/elimina  una password
    /// - Parameters:
    ///   - account: Nome account
    ///   - service: Nome servizio
    func deleteGenericPasswordFor(account: String, service: String) throws {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
    
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    
}

