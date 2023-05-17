//
//  CalendarListEntity.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 12/05/23.
//

import Foundation

public struct CalendarListEntity {
    private (set) var list: [CalendarEntity]
    private (set) var title: String
    
    init(list: [CalendarEntity] = [], title: String = "") {
        self.list = list
        self.title = title
    }
    
    mutating func append(_ entity: CalendarEntity) {
        list.append(entity)
    }
    
    mutating func removeAll() {
        list.removeAll()
    }
    
    func item(with id: UUID) -> CalendarEntity? {
        return list.first(where: { $0.id == id })
    }
    
    func item(with date: Date) -> CalendarEntity? {
        return list.first(where: { $0.date == date })
    }
    
    func listID() -> [UUID] {
        return list.map { $0.id }
    }
    
    mutating func repace(_ entity: CalendarEntity) {
        guard let actualItem = item(with: entity.id) else { return }
        if let index = list.firstIndex(of: actualItem) {
            list[index] = entity
        }
    }

    mutating func updateImage(_ id: UUID, newImage: String) {
        guard let item = list.filter({ $0.id == id }).first else { return }
        list.enumerated().forEach { (index, value) in
            if item == value {
                list[index].beanImage = newImage
            }
        }
    }
    
    func item(_ index: Int) -> CalendarEntity? {
        if index < list.count {
            return list[index]
        }
       return nil
    }
}
