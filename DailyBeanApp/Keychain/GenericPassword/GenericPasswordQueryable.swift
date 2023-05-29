//
//  GenericPasswordQueryable.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 25/05/23.
//

import Foundation

public struct GenericPasswordQueryable {
  let service: String
  
  init(service: String) {
    self.service = service
  }
}

extension GenericPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    return query
  }
}
