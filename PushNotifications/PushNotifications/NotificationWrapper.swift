//
//  NotificationWrapper.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/04.
//  Copyright © 2018 Heva. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationWrapper {
    static let shared: NotificationWrapper = NotificationWrapper()
    
    let center: UNUserNotificationCenter
    init() {
        center = UNUserNotificationCenter.current()
    }
    
    /// Request Authorization at Launch Time
    func requestAuthorization() {
        requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            // Enable or disable features based on authorization
            
            // If denied, notify a remote notification server not to send notifications to the user’s device.
        }
    }
    
    /// Check which types of interactions that you can use
    func getNotificationSettings() {
        getNotificationSettings { settings in
            // Do not schedule notifications if not authorized
            guard settings.authorizationStatus == .authorized else {
                return
            }
            
            if settings.alertSetting == .enabled {
                // Schedule an alert-only notification
            } else {
                // Schedule a notification with a badge and sound
            }
        }
    }
    
    private func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        center.requestAuthorization(options: options, completionHandler: completionHandler)
    }
    
    private func getNotificationSettings(completionHandler: @escaping (UNNotificationSettings) -> Void) {
        center.getNotificationSettings(completionHandler: completionHandler)
    }
}
