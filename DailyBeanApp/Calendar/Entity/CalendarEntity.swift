//
//  CalendarViewEntity.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 12/05/23.
//

import Foundation

struct CalendarEntity: Equatable, Hashable {
    let id: String = UUID().uuidString
    var day: String?
    var beanImage: String?
    var date: Date?
    
    init(day: String? = nil, date: Date? = nil) {
        self.day = day
        self.date = date
    }
    
    mutating func setBackgroundImage(_ beanImage: String) {
        self.beanImage = beanImage
    }
}
