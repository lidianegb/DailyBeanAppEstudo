//
//  SelectBeanView.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 09/05/23.
//

import UIKit
import RxSwift

class SelectBeanView: UIView {
    var beanStatus = BehaviorSubject<BeanStatus>(value: .neutral)
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Como foi o seu dia?"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupViewHierarchy()
        setupConstraints()
        backgroundColor = .white
    }
    
    private func setupViewHierarchy() {
        addSubview(vStackView)
        vStackView.addArrangedSubview(title)
        vStackView.addArrangedSubview(hStackView)
        BeanStatus.allCases.forEach { status in
            let buttonView = BeanButton()
                .withStatus(status)
                .withAction(action: { [weak self] status in
                    self?.beanStatus.onNext(status)
                })
                .build()
            buttonView.translatesAutoresizingMaskIntoConstraints = false
            buttonView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            buttonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            hStackView.addArrangedSubview(buttonView)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

}
