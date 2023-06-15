//
//  TimelineViewModel.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 18/05/23.
//

import Foundation

protocol TimelineViewModelProtocol {
    func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ())
    func scheduleLocalNotification(date: Date)
    func disableNotification()
}

class TimelineViewModel: TimelineViewModelProtocol {
    func disableNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func requestAuthorization(completionHandler: @escaping (Bool) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if let error {
                print("Request Authorization Failded (\(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    
    func scheduleLocalNotification(date: Date) {
        disableNotification()
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Olá!"
        notificationContent.subtitle = "Não se esqueça de registrar o seu dia!"
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
    
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationRequest = UNNotificationRequest(identifier: "dailyBean_local_notification", content: notificationContent, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest) { error in
            if let error {
                print("Unable to Add Notification Request (\(error.localizedDescription))")
            }
        }
    }
}
