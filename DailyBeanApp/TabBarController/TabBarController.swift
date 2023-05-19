//
//  TabBarController.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 20/04/23.
//

import Foundation
import UIKit
import RxSwift

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var statusHelper: BeanStatusHelper?
    var viewModel: TabBarViewModelProtocol?
    private let disposeBag = DisposeBag()
    private var showSelectBeanView = false {
        didSet {
            animateBeanVisibility()
        }
    }
   
    private lazy var selectBeanView: SelectBeanView = {
        let view = SelectBeanView(beanStatus: statusHelper)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.alpha = .zero
        return view
    }()
    
    private lazy var button: BeanButton = {
        let button = BeanButton()
            .withAction(action: { [weak self] _ in
                self?.showSelectBeanView.toggle()
            })
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        if let beanStatus = viewModel?.getBeanStatus() {
            button.updateStatus(beanStatus)
            statusHelper?.observableStatus.onNext(beanStatus)
        }
    }
    
    private func setup() {
        setupTabBarItems()
        setupViewHierarchy()
        setupConstraints()
        setupObservables()
    }
    
    private func setupObservables() {
        statusHelper?.observableStatus.subscribe(onNext: { [weak self] status in
            self?.button.updateStatus(status)
            self?.showSelectBeanView = false
        }).disposed(by: disposeBag)
    }
    
    private func animateBeanVisibility() {
        selectBeanView.isHidden = !showSelectBeanView
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.selectBeanView.alpha = self.showSelectBeanView ? 1 : 0
        }
    }
    
    private func setupTabBarItems() {
        guard let viewModel else { return }
        let calendarController = viewModel.makeTabBarCalendar()
        let timeLineController = viewModel.makeTabBarTimeline()
        self.viewControllers = [calendarController, timeLineController]
    }
 
    private func setupViewHierarchy() {
        tabBar.addSubview(button)
        tabBar.addSubview(selectBeanView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -tabBar.frame.height),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 70),
            
            selectBeanView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 24),
            selectBeanView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -20),
            selectBeanView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -56)
        ])
    }
}
