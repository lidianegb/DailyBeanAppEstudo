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
            return TabBarViewModel(factory: factory)
        }
       
        // MARK: CLASS
        
        container.register(CalendarViewController.self) { _ in
            return CalendarViewController()
        }
        
        container.register(TimelineViewController.self) { _ in
            return TimelineViewController()
        }
        
        container.storyboardInitCompleted(TabBarController.self) { resolver, tab in
            tab.viewModel = resolver.resolveUnwrapping(TabBarViewModelProtocol.self)
        }
    }
}
