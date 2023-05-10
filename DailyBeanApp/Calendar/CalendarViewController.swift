//
//  CalendarViewController.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 20/04/23.
//

import UIKit

class CalendarViewController: UIViewController {

    let customView = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        
    }
    
    override func loadView() {
        self.view = customView
    }
}
