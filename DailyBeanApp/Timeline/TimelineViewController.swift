//
//  TimelineViewController.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 20/04/23.
//

import UIKit

class TimelineViewController: UIViewController {

    private let customView: TimelineView
    private let viewModel: TimelineViewModelProtocol
    
    
    init(view: TimelineView, viewModel: TimelineViewModelProtocol) {
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        self.view = customView
    }
}
