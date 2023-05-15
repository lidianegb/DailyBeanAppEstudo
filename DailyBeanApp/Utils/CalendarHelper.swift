//
//  CalendarHelper.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 12/05/23.
//

import Foundation
import UIKit

class CalendarHelper {
    private let calendar = Calendar.current
    
    func plusMonth(_ date: Date) -> Date? {
        return calendar.date(byAdding: .month, value: 1, to: date)
    }
    
    func minusMonth(_ date: Date) -> Date? {
        return calendar.date(byAdding: .month, value: -1, to: date)
    }
    
    func generateDate(_ date: Date, day: Int) -> Date? {
        var dateComponents = calendar.dateComponents([.year, .month], from: date)
        dateComponents.day = day
        return calendar.date(from: dateComponents)
    }
    
    func monthString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count ?? .zero
    }
    
    func isPast(_ date: Date) -> Bool {
        date < Date()
    }
    
    func today() -> Date {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        return calendar.date(from: dateComponents) ?? Date()
    }
    
    func firstOfMonth(_ date: Date) -> Date? {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)
    }
    
    func weekDay(_ date: Date) -> Int {
        let component = calendar.dateComponents([.weekday], from: date)
        return (component.weekday ?? .zero) - 1
    }
}
