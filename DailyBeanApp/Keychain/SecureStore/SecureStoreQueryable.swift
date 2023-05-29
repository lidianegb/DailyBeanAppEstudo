//
//  SecureStoreQueryable.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 24/05/23.
//

import Foundation

public protocol SecureStoreQueryable {
  var query: [String: Any] { get }
}
