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
    var observableStatus: PublishSubject<(UUID, BeanStatus)> { get }
    
    func plusMonth()
    func minusMonth()
    func updateDailyStatus(_ status: BeanStatus)
}

class CalendarViewModel: CalendarViewModelProtocol {
    private let calendarHelper: CalendarHelper
    private let securePersistence: SecureStatusStore
    private var listEntity: CalendarListEntity?
    
    private var selectedDate = Date() {
        didSet {
            updateMonthView()
        }
    }
    
    var observableEntity = BehaviorSubject<CalendarListEntity>(value: CalendarListEntity())
    var observableStatus = PublishSubject<(UUID, BeanStatus)>()
    
    init(calendarHelper: CalendarHelper, securePersistence: SecureStatusStore) {
        self.calendarHelper = calendarHelper
        self.securePersistence = securePersistence
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
        let title = calendarHelper.monthString(selectedDate).capitalized + " " + calendarHelper.yearString(selectedDate)
       
        listEntity = CalendarListEntity(title: title)
       
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
                    let image = securePersistence.getStatus(for: actualDate)
                    calendarEntity.beanImage = image.rawValue
                }
                listEntity?.append(calendarEntity)
            }
            count += 1
        }
        
        if let listEntity {
            observableEntity.onNext(listEntity)
        }
    }
    
    func updateDailyStatus(_ status: BeanStatus) {
        if let item = listEntity?.item(with: calendarHelper.today()) {
            observableStatus.onNext((item.id, status))
            securePersistence.saveDailyStatus(status)
        }
    }
}
