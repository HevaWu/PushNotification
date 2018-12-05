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
final class NotificationWrapper: NSObject {
    static let shared: NotificationWrapper = NotificationWrapper()
    
    private let _center: UNUserNotificationCenter
    
    override init() {
        _center = UNUserNotificationCenter.current()
    }
    
    // MARK: - Authorization
    
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
    
    // MARK: - Requests
    
    func add(_ request: UNNotificationRequest) {
        _center.add(request) { error in
            // TODO: Process error
        }
    }
    
    func removeAllPendingNotificationRequests() {
        _center.removeAllPendingNotificationRequests()
    }
    
    func remove(withIdentifiers: [String]) {
        _center.removeDeliveredNotifications(withIdentifiers: withIdentifiers)
    }
    
    // MARK: - Actions

    func registerNoticeType() {
        _center.setNotificationCategories([NoticeCategory.showFirstPage])
    }
    
    // MARK: - Delegate
    
    // TODO: maybe combine setDelegate() & registerNoticeType()
    func setDelegate() {
        _center.delegate = self
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

// MARK: - NotificationCenter Delegate(Action processing)

extension NotificationWrapper: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case NoticeActionIdentifier.ACCEPT_ACTION.rawValue:
            print("Accept Action")
            break
        case NoticeActionIdentifier.DECLINE_ACTION.rawValue:
            print("Decline Action")
            break
        default:
            break
        }
        
        // Note: always need to call the completion handler when done
        defer {
            completionHandler()
        }
    }
}
