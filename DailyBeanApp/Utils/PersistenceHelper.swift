//
//  PersistenceHelper.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 15/05/23.
//

import Foundation

class PersistenceHelper {
    private let defaults = UserDefaults.standard
    private let calendar: CalendarHelper
    
    init(calendar: CalendarHelper) {
        self.calendar = calendar
    }
    
    func saveDailyStatus(_ status: BeanStatus) {
        defaults.set(status.rawValue, forKey: calendar.today().description)
    }
    
    func getStatus(for date: Date) -> BeanStatus {
        let statusName = defaults.string(forKey: date.description) ?? "default"
        return BeanStatus(rawValue: statusName) ?? .default
    }
    
    func getTodayStatus() -> BeanStatus {
        let statusName = defaults.string(forKey: calendar.today().description) ?? "neutral"
        return BeanStatus(rawValue: statusName) ?? .neutral
    }
}
