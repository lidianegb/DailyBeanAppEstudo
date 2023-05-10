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
    
    var viewModel: TabBarViewModelProtocol?
    private let disposeBag = DisposeBag()
  
    private lazy var selectBeanView: SelectBeanView = {
        let view = SelectBeanView()
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
                self?.viewModel?.setBeanViewVisibility()
            })
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTabBarItems()
        setupButton()
        setupObservables()
    }
    
    private func setupObservables() {
        viewModel?.showBeanOtions.subscribe(onNext: { [weak self] value in
            self?.selectBeanView.isHidden = !value
            UIView.animate(withDuration: 0.3, delay: 0) {
                self?.selectBeanView.alpha = value ? 1 : 0
            }
        }).disposed(by: disposeBag)
        
        selectBeanView.beanStatus.subscribe { [weak self] status in
            self?.button.updateStatus(status)
            self?.viewModel?.setBeanViewVisibility(false)
        }.disposed(by: disposeBag)
    }
    
    private func setupButton() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupTabBarItems() {
        let calendarController = viewModel?.makeTabBarCalendar() ?? UIViewController()
        let timeLineController = viewModel?.makeTabBarTimeline() ?? UIViewController()
        
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
