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
    
    init(day: String? = nil, beanImage: String? = nil) {
        self.day = day
        self.beanImage = beanImage
    }
    
    mutating func setBackgroundImage(_ beanImage: String) {
        self.beanImage = beanImage
    }
}
