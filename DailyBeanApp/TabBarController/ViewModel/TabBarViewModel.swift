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
    
    func getBeanStatus() -> BeanStatus
    func makeTabBarCalendar() -> CalendarViewController
    func makeTabBarTimeline() -> UIViewController
}

final class TabBarViewModel {
    let persistenceHelper: PersistenceHelper
    var factory: DailyBeanFactoryProtocol
 
    init(factory: DailyBeanFactoryProtocol, persistenceHelper: PersistenceHelper) {
        self.factory = factory
        self.persistenceHelper = persistenceHelper
    }
}

extension TabBarViewModel: TabBarViewModelProtocol {
    func getBeanStatus() -> BeanStatus {
        return persistenceHelper.getTodayStatus()
    }
    
    func makeTabBarCalendar() -> CalendarViewController {
        factory.makeTabCalendar(title: "calendário", imageName: "calendar")
    }
    
    func makeTabBarTimeline() -> UIViewController {
        factory.makeTabTimeline(title: "timeline", imageName: "calendar.day.timeline.leading")
    }
}
