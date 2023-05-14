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
    
    func setBeanViewVisibility(_ show: Bool)
    func setBeanViewVisibility()
    func makeTabBarCalendar() -> CalendarViewController
    func makeTabBarTimeline() -> UIViewController
}

final class TabBarViewModel {
    var factory: DailyBeanFactoryProtocol
    var showBeanOtions = BehaviorSubject<Bool>(value: false)
    
    private var showBeanView: Bool = false {
        didSet {
            showBeanOtions.onNext(showBeanView)
        }
    }

    init(factory: DailyBeanFactoryProtocol) {
        self.factory = factory
    }
}

extension TabBarViewModel: TabBarViewModelProtocol {
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
