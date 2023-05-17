//
//  CalendarViewController.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 20/04/23.
//

import UIKit
import RxSwift

class CalendarViewController: UIViewController {

    private let customView: CalendarView
    private let viewModel: CalendarViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(view: CalendarView, viewModel: CalendarViewModelProtocol) {
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }
    
    override func loadView() {
        self.view = customView
    }
    
    private func setupObservables() {
        customView.observableDirection.subscribe { [weak self] direction in
            switch direction {
            case .next:
                self?.viewModel.plusMonth()
            case .preview:
                self?.viewModel.minusMonth()
            }
        }.disposed(by: disposeBag)
        
        viewModel.observableEntity.subscribe { [weak self] entity in
            self?.customView.updateView(entity)
        }.disposed(by: disposeBag)
        
        viewModel.observableStatus.subscribe { [weak self] (id, status) in
            self?.customView.updateSnapshot(id, status: status)
        }.disposed(by: disposeBag)
    }
    
    func updateDailyStatus(_ status: BeanStatus) {
        viewModel.updateDailyStatus(status)
    }
}
