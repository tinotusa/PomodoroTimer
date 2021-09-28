//
//  NotificationManager.swift
//  PomodoroTimer
//
//  Created by Tino on 28/9/21.
//

import UserNotifications

final class NotificationManager: ObservableObject {
    static var center = UNUserNotificationCenter.current()
    var notifications: [String] = []
    
    func requestAuthorization() {
        Self.center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error as NSError? {
                print("Failed request for notifications\n \(error)")
            }
        }
    }
    
    func removeNotification() {
        Self.center.removePendingNotificationRequests(withIdentifiers: notifications)
        notifications.removeAll()
    }
    
    func addNotification(timeInterval: Double) {
        // content
        let content = UNMutableNotificationContent()
        content.title = "Time's up"
        content.body = "The pomodoro session is over"
        content.sound = .default
        
        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

        // request
        let id = UUID().uuidString
        notifications.append(id)
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )
        
        // schedule
        Self.center.add(request) { error in
            if let error = error {
                print("Failed to add notification request.\n\(error)")
            }
        }
    }
}
