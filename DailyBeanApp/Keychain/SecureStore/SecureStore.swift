//
//  SecureStore.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 24/05/23.
//

import Foundation
import Security

public struct SecureStore {
    let secureStoreQueryable: SecureStoreQueryable
    let attrKey: CFString
    
    public init(secureStoreQueryable: SecureStoreQueryable, attrKey: CFString) {
        self.secureStoreQueryable = secureStoreQueryable
        self.attrKey = attrKey
    }
    
    public func setValue(_ value: String, for key: String) throws {
        guard let encodedValue = value.data(using: .utf8) else {
            throw SecureStoreError.string2DataConversionError
        }
        
        var query = secureStoreQueryable.query
        query[String(attrKey)] = key
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedValue
            
            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw error(from: status)
            }
            
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedValue
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
        
    }
    
    public func getValue(for key: String) throws -> String? {
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(attrKey)] = key

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
          SecItemCopyMatching(query as CFDictionary, $0)
        }

        switch status {
        case errSecSuccess:
          guard
            let queriedItem = queryResult as? [String: Any],
            let valueData = queriedItem[String(kSecValueData)] as? Data,
            let value = String(data: valueData, encoding: .utf8)
            else {
              throw SecureStoreError.data2StringConversionError
          }
          return value
        case errSecItemNotFound:
          return nil
        default:
          throw error(from: status)
        }
    }
    
    public func removeValue(for userAccount: String) throws {
        var query = secureStoreQueryable.query
        query[String(attrKey)] = userAccount

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
          throw error(from: status)
        }
    }
    
    public func removeAllValues() throws {
        let query = secureStoreQueryable.query
          
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
          throw error(from: status)
        }

    }
    
    private func error(from status: OSStatus) -> SecureStoreError {
        let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
        return SecureStoreError.unhandledError(message: message)
    }
}
