//
//  NoticeService.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/04.
//  Copyright © 2018 Heva. All rights reserved.
//

import Foundation
import UserNotifications

class NoticeService {
    static let shared: NoticeService = NoticeService()
    
    private let _noticeWrapper: NotificationWrapper
    init() {
        _noticeWrapper = NotificationWrapper.shared
    }
    
    func setup() {
        _noticeWrapper.requestAuthorization()
    }
    
    func schedule(content: UNMutableNotificationContent, after timeInterval: TimeInterval) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        
    }
}
