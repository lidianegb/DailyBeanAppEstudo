//
//  DailyBeanFactoryProtocol.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 02/05/23.
//

import UIKit

protocol DailyBeanFactoryProtocol {
    func makeCalendar() -> CalendarViewController
    func makeTimeline() -> UIViewController
    func makeTabCalendar(title: String, imageName: String) -> CalendarViewController
    func makeTabTimeline(title: String, imageName: String) -> UIViewController
}
