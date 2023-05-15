//
//  PersistenceHelper.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 15/05/23.
//

import Foundation

class PersistenceHelper {
    private let defaults = UserDefaults.standard
    
    func saveCalendarEntity(_ date: Date, beanImage: String) {
        defaults.set(beanImage, forKey: date.description)
    }
    
    func getImage(_ date: Date) -> String {
        return defaults.string(forKey: date.description) ?? "default"
    }
}
