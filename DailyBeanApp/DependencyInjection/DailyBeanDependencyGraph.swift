//
//  DailyBeanDependencyGraph.swift
//  DailyBean
//
//  Created by Lidiane Gomes Barbosa on 04/05/23.
//

import Foundation
import Swinject

final class DailyBeanDependencyGraph {
    static func build() -> [Assembly] {
        return [DailyBeanAssembly()]
    }
}
