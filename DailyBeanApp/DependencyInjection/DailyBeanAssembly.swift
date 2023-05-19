//
//  DailyBeanAssembly.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 04/05/23.
//

import Foundation
import Swinject
import SwinjectStoryboard

final class DailyBeanAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: FACTORY
        
        container.register(DailyBeanFactoryProtocol.self) { resolver in
            return DailyBeanFactory(resolver: resolver)
        }
        
        // MARK: VIEWMODEL
        
        container.register(TabBarViewModelProtocol.self) { resolver in
            let factory = resolver.resolveUnwrapping(DailyBeanFactoryProtocol.self)
            let persistence = resolver.resolveUnwrapping(PersistenceHelper.self)
        
            return TabBarViewModel(factory: factory, persistenceHelper: persistence)
        }
        
        container.register(CalendarViewModelProtocol.self) { resolver in
            let persistence = resolver.resolveUnwrapping(PersistenceHelper.self)
            let calendarHelper = resolver.resolveUnwrapping(CalendarHelper.self)
            return CalendarViewModel(calendarHelper: calendarHelper, persistenceHelper: persistence)
        }
        
        container.register(TimelineViewModelProtocol.self) { resolver in
            return TimelineViewModel()
        }
       
        // MARK: CLASS
        
        container.register(CalendarViewController.self) { resolver in
            let customView = CalendarView()
            let viewModel = resolver.resolveUnwrapping(CalendarViewModelProtocol.self)
            let statusHelper = resolver.resolveUnwrapping(BeanStatusHelper.self)
            return CalendarViewController(view: customView, viewModel: viewModel, statusHelper: statusHelper)
        }
        
        container.register(TimelineViewController.self) { resolver in
            let customView = TimelineView()
            let viewModel = resolver.resolveUnwrapping(TimelineViewModelProtocol.self)
            return TimelineViewController(view: customView, viewModel: viewModel)
        }
        
        container.storyboardInitCompleted(TabBarController.self) { resolver, tab in
            tab.viewModel = resolver.resolveUnwrapping(TabBarViewModelProtocol.self)
            tab.statusHelper = resolver.resolveUnwrapping(BeanStatusHelper.self)
        }
        
        // MARK: HELPERS
        
        container.register(PersistenceHelper.self) { resolver in
            let calendarHelper = resolver.resolveUnwrapping(CalendarHelper.self)
            return PersistenceHelper(calendar: calendarHelper)
        }
        
        container.register(CalendarHelper.self) { resolver in
            return CalendarHelper(calendar: Calendar.current)
        }
        
        container.register(BeanStatusHelper.self) { _ in
            return BeanStatusHelper()
        }.inObjectScope(.container)
    }
}
