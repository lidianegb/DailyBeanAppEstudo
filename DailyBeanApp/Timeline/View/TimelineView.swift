//
//  TimelineView.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

import UIKit

class TimelineView: UIView {

    private lazy var reminderView: ReminderView = {
        let view = ReminderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.primaryColor = .primary
        view.delegate = self
        view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.backgroundColor
        setupViewHierarchy()
        setupConstraints()
    }
 
    private func setupViewHierarchy() {
       addSubview(reminderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            reminderView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            reminderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            reminderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            reminderView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -24)
        ])
    }
}

extension TimelineView: ReminderViewDelegate {
    func selectedDate(_ date: String) {
        print(date)
    }
}
