//
//  NoticeService.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/04.
//  Copyright © 2018 Heva. All rights reserved.
//

import Foundation
import UserNotifications

final class NoticeService {
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
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        _noticeWrapper.add(request)
    }
    
    func cancelAllSchedule() {
        _noticeWrapper.removeAllPendingNotificationRequests()
    }
    
    func cancelSchedule(for requestsIdentifiers: [String]) {
        _noticeWrapper.remove(withIdentifiers: requestsIdentifiers)
    }
}
