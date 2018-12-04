//
//  NotificationWrapper.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/04.
//  Copyright © 2018 Heva. All rights reserved.
//

import UIKit
import UserNotifications

/// Wrapper UserNotifications methods
final class NotificationWrapper {
    static let shared: NotificationWrapper = NotificationWrapper()
    
    private let _center: UNUserNotificationCenter
    private var _noticeRequestManager: [UNNotificationRequest] = []
    
    init() {
        _center = UNUserNotificationCenter.current()
    }
    
    /// Request Authorization at Launch Time
    func requestAuthorization() {
        _center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            // TODO: Enable or disable features based on authorization
            if !granted {
                self?._showDeniedDialog()
            }
            
            // TODO: If denied, notify a remote notification server not to send notifications to the user’s device.
        }
    }
    
    /// Check which types of interactions that you can use
    func getNotificationSettings() {
        _center.getNotificationSettings { settings in
            // Do not schedule notifications if not authorized
            guard settings.authorizationStatus == .authorized else {
                return
            }
            
            if settings.alertSetting == .enabled {
                // TODO: Schedule an alert-only notification
            } else {
                // TODO: Schedule a notification with a badge and sound
            }
        }
    }
    
    func add(_ request: UNNotificationRequest) {
        _center.add(request) { error in
            // TODO: Process error
        }
        _noticeRequestManager.append(request)
    }
    
    func removeAllPendingNotificationRequests() {
        _center.removeAllPendingNotificationRequests()
    }
    
    func remove(withIdentifiers: [String]) {
        _center.removeDeliveredNotifications(withIdentifiers: withIdentifiers)
    }
}

private extension NotificationWrapper {
    /// Show the denied dialog
    func _showDeniedDialog() {
        // TODO: update to use dialog things later, or maybe some time stamp
        DispatchQueue.main.async {
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                let alertController = UIAlertController(title: "Push Notification is Denied", message: "Please go to Settings and allow to push notifications", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okButton)
                
                if vc.presentedViewController != nil {
                    alertController.dismiss(animated: false) { [alertController] in
                        vc.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    vc.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
