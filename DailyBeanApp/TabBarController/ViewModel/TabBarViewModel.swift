//
//  TabBarViewModel.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 10/05/23.
//

import Foundation
import UIKit
import RxSwift

protocol TabBarViewModelProtocol {
    var factory: DailyBeanFactoryProtocol { get }
    var showBeanOtions: BehaviorSubject<Bool> { get }
    
    func getBeanStatus() -> BeanStatus
    func setBeanViewVisibility(_ show: Bool)
    func setBeanViewVisibility()
    func makeTabBarCalendar() -> CalendarViewController
    func makeTabBarTimeline() -> UIViewController
}

final class TabBarViewModel {
    let persistenceHelper: PersistenceHelper
    let calendarHelper: CalendarHelper
    var factory: DailyBeanFactoryProtocol
    var showBeanOtions = BehaviorSubject<Bool>(value: false)
    
    private var showBeanView: Bool = false {
        didSet {
            showBeanOtions.onNext(showBeanView)
        }
    }

    init(factory: DailyBeanFactoryProtocol, persistenceHelper: PersistenceHelper, calendarHelper: CalendarHelper) {
        self.factory = factory
        self.persistenceHelper = persistenceHelper
        self.calendarHelper = calendarHelper
    }
}

extension TabBarViewModel: TabBarViewModelProtocol {
    func getBeanStatus() -> BeanStatus {
        let image = persistenceHelper.getImage(calendarHelper.today())
        return BeanStatus(rawValue: image) ?? .neutral
    }
    
    func setBeanViewVisibility(_ show: Bool) {
        showBeanView = show
    }
    
    func setBeanViewVisibility() {
        showBeanView.toggle()
    }
    
    func makeTabBarCalendar() -> CalendarViewController {
        factory.makeTabCalendar(title: "calendário", imageName: "calendar")
    }
    
    func makeTabBarTimeline() -> UIViewController {
        factory.makeTabTimeline(title: "timeline", imageName: "calendar.day.timeline.leading")
    }
}
