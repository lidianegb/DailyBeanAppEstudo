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
    let securePersistence: SecureStatusStore
    var factory: DailyBeanFactoryProtocol
 
    init(factory: DailyBeanFactoryProtocol, securePersistence: SecureStatusStore) {
        self.factory = factory
        self.securePersistence = securePersistence
    }
}

extension TabBarViewModel: TabBarViewModelProtocol {
    func getBeanStatus() -> BeanStatus {
        return securePersistence.getTodayStatus()
    }
    
    func makeTabBarCalendar() -> CalendarViewController {
        factory.makeTabCalendar(title: "calendário", imageName: "calendar")
    }
    
    func makeTabBarTimeline() -> UIViewController {
        factory.makeTabTimeline(title: "timeline", imageName: "calendar.day.timeline.leading")
    }
}
