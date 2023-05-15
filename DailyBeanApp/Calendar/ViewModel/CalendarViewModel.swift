//
//  CalendarViewModel.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 12/05/23.
//

import Foundation
import RxSwift

protocol CalendarViewModelProtocol {
    var observableEntity: BehaviorSubject<CalendarListEntity> { get }
    var observableID: PublishSubject<(String, String)> { get }
    func plusMonth()
    func minusMonth()
    func updateTodayImage(_ newImage: String)
}

class CalendarViewModel: CalendarViewModelProtocol {
    private let calendarHelper: CalendarHelper
    private let persistenceHelper: PersistenceHelper
    private var listEntity: CalendarListEntity?
    
    private var selectedDate = Date() {
        didSet {
            updateMonthView()
        }
    }
    
    var observableEntity = BehaviorSubject<CalendarListEntity>(value: CalendarListEntity())
    var observableID = PublishSubject<(String, String)>()
    
    init(calendarHelper: CalendarHelper, persistenceHelper: PersistenceHelper) {
        self.calendarHelper = calendarHelper
        self.persistenceHelper = persistenceHelper
        updateMonthView()
    }
    
    func plusMonth() {
        selectedDate = calendarHelper.plusMonth(selectedDate) ?? Date()
    }
    
    func minusMonth() {
        selectedDate = calendarHelper.minusMonth(selectedDate) ?? Date()
    }
    
    private func updateMonthView() {
        listEntity?.removeAll()
        
        let daysInMonth = calendarHelper.daysInMonth(selectedDate)
        let firstDayInMonth = calendarHelper.firstOfMonth(selectedDate)
        let startingSpaces = calendarHelper.weekDay(firstDayInMonth ?? selectedDate)
        let monthString = calendarHelper.monthString(selectedDate).capitalized
       
        listEntity = CalendarListEntity(month: monthString)
       
        var count: Int = 1
        
        while(count <= 42) {
            if (count <= startingSpaces || count - startingSpaces > daysInMonth ) {
                let calendarEntity = CalendarEntity()
                listEntity?.append(calendarEntity)
                
            } else {
                let day = count - startingSpaces
                let actualDate = calendarHelper.generateDate(selectedDate, day: day) ?? Date()
                var calendarEntity = CalendarEntity(day: String(day), date: actualDate)
                
                if calendarHelper.isPast(actualDate) {
                    let image = persistenceHelper.getImage(actualDate)
                    calendarEntity.setBackgroundImage(image)
                }
                listEntity?.append(calendarEntity)
            }
            count += 1
        }
        
        if let listEntity {
            observableEntity.onNext(listEntity)
        }
    }
    
    func updateTodayImage(_ newImage: String) {
        let item = listEntity?.item(with: calendarHelper.today())
    
        if let item {
            observableID.onNext((item.id, newImage))
            persistenceHelper.saveCalendarEntity(calendarHelper.today(), beanImage: newImage)
        }
    }
}
