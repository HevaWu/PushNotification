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

    var noticeManager: [Notice] = []
    
    private let _noticeWrapper: NotificationWrapper
    init() {
        _noticeWrapper = NotificationWrapper.shared
    }
    
    func setup() {
        _noticeWrapper.requestAuthorization()
    }
    
    func registerNotices(after timeInterval: TimeInterval) {
        for notice in noticeManager {
            schedule(content: Notice.generateContent(from: notice), after: timeInterval)
        }
    }
    
    func schedule(content: UNMutableNotificationContent, after timeInterval: TimeInterval) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        _noticeWrapper.add(request)
    }
    
    func schedule(content: UNMutableNotificationContent, at dateComponents: DateComponents) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
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
