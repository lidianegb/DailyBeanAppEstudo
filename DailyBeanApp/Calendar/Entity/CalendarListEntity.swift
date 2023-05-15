//
//  CalendarListEntity.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 12/05/23.
//

import Foundation

public struct CalendarListEntity {
    private (set) var list: [CalendarEntity]
    private (set) var month: String
    
    init(list: [CalendarEntity] = [], month: String = "") {
        self.list = list
        self.month = month
    }
    
    mutating func append(_ entity: CalendarEntity) {
        list.append(entity)
    }
    
    mutating func removeAll() {
        list.removeAll()
    }
    
    func item(with id: String) -> CalendarEntity? {
        return list.first(where: { $0.id == id })
    }
    
    func item(with date: Date) -> CalendarEntity? {
        return list.first(where: { $0.date == date })
    }
    
    func listID() -> [String] {
        return list.map { $0.id }
    }
    
    mutating func repace(_ entity: CalendarEntity) {
        guard let actualItem = item(with: entity.id) else { return }
        if let index = list.firstIndex(of: actualItem) {
            list[index] = entity
        }
    }
    
    func indexOfItem(_ item: CalendarEntity) -> Int? {
        return list.firstIndex(of: item)
    }
    
    mutating func updateImage(_ id: String, newImage: String) {
        guard let item = item(with: id), let index = indexOfItem(item) else { return }
        list[index].beanImage = newImage
    }
    
    func item(_ index: Int) -> CalendarEntity? {
        if index < list.count {
            return list[index]
        }
       return nil
    }
}
