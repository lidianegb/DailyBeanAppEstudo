//
//  SecureStatusQueryable.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 25/05/23.
//

import Foundation

public struct SecureStatusQueryable { }

extension SecureStatusQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
      var query: [String: Any] = [:]
      query[String(kSecClass)] = kSecClassKey
      return query
  }
}
