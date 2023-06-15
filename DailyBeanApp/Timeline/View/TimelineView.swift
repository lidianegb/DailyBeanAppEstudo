//
//  TimelineView.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

import UIKit

protocol TimelineViewDelegate: AnyObject {
    func navigateToSettings()
    func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ())
    func scheduleLocalNotification(date: Date)
    func disableNotification()
}

class TimelineView: UIView {

    private lazy var reminderView: ReminderView = {
        let view = ReminderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.primaryColor = .primary
        view.delegate = self
        view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }()
    
    weak var delegate: TimelineViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reminderView.layer.masksToBounds = true
        reminderView.layer.cornerRadius = 8
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
            reminderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            reminderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            reminderView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100)
        ])
    }
}

extension TimelineView: ReminderViewDelegate {
    func disableNotification() {
        delegate?.disableNotification()
    }
    
    func selectedDate(_ date: Date, completed completion: @escaping (_ success: Bool) -> ()) {
        UNUserNotificationCenter.current().getNotificationSettings { [delegate] notificationSettings in
            switch notificationSettings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                delegate?.scheduleLocalNotification(date: date)
                completion(true)
            default:
                delegate?.requestAuthorization { success in
                    guard success else {
                        completion(success)
                        delegate?.navigateToSettings()
                        return
                    }
                    delegate?.scheduleLocalNotification(date: date)
                    completion(success)
                }
            }
        }
    }
}
