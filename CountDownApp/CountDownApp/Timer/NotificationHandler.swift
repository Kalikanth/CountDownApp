//
//  NotificationHandler.swift
//  CountDownApp
//
//  Created by kiran kumar Gajula on 13/01/24.
//

import Foundation
import UserNotifications

protocol NotificationProtocol: AnyObject {
    func requestAuthorization()
    func getNotificationAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void)
    func sendLocalNotification(uuid:String,timeInterval: TimeInterval,title: String, body: String) 
}

class NotificationHandler: NSObject,NotificationProtocol, UNUserNotificationCenterDelegate {
    
    var notificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            print("requestAuthorization >\(success)")
        }
    }
    
    func getNotificationAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            let authorizationStatus = settings.authorizationStatus
            completion(authorizationStatus)
        }
    }

    func sendLocalNotification(uuid:String,timeInterval: TimeInterval,title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification request: \(error.localizedDescription)")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func removeScheduledNotification(withIdentifier identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}

