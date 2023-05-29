//
//  SecureStatusStore.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 25/05/23.
//

import Foundation
import Security

struct SecureStatusStore {
    private let secureStore: SecureStore
    private let calendar: CalendarHelper
    
    public init(calendar: CalendarHelper, secureStore: SecureStore) {
        self.calendar = calendar
        self.secureStore = secureStore
    }
    
    func saveStatus(_ status: BeanStatus, for date: Date) {
        try? secureStore.setValue(status.rawValue, for: date.description)
    }
    
    func saveDailyStatus(_ status: BeanStatus) {
        try? secureStore.setValue(status.rawValue, for: calendar.today().description)
    }
    
    func getStatus(for date: Date) -> BeanStatus {
        guard let statusName = try? secureStore.getValue(for: date.description) ?? "default" else { return .default }
        return BeanStatus(rawValue: statusName) ?? .default
    }
    
    func getTodayStatus() -> BeanStatus {
        guard let statusName = try? secureStore.getValue(for: calendar.today().description) ?? "neutral" else { return .neutral }
        return BeanStatus(rawValue: statusName) ?? .neutral
    }
  
    public func removeAllValues() {
       try? secureStore.removeAllValues()
    }
}
