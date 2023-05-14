//
//  DailyBeanFactory.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 02/05/23.
//

import UIKit
import Swinject

class DailyBeanFactory: DailyBeanFactoryProtocol {
    
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func makeCalendar() -> CalendarViewController {
        resolver.resolveUnwrapping(CalendarViewController.self)
    }
    
    func makeTimeline() -> UIViewController {
        resolver.resolveUnwrapping(TimelineViewController.self)
    }
    
    func makeTabCalendar(title: String, imageName: String) -> CalendarViewController {
        let controller = makeCalendar()
        let tab = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: 0)
        tab.titlePositionAdjustment = UIOffset(horizontal: -20, vertical: 0)
        controller.tabBarItem = tab
        return controller
    }
    
    func makeTabTimeline(title: String, imageName: String) -> UIViewController {
        let controller = makeTimeline()
        let tab = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: 1)
        tab.titlePositionAdjustment = UIOffset(horizontal: 20, vertical: 0)
        controller.tabBarItem = tab
        return controller
    }
}

extension Resolver {
    public func resolveUnwrapping<Service>(_ serviceType: Service.Type) -> Service {
        if let resolution = resolve(serviceType) {
            return resolution
        }
        fatalError("\(serviceType) resolution failed")
    }
}
