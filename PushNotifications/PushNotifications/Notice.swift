//
//  Notice.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/04.
//  Copyright © 2018 Heva. All rights reserved.
//

import Foundation
import UserNotifications

struct Notice {
    let title: String
    let body: String
    let categoryIdentifier: String
}

extension Notice {
    static func generateContent(from notice: Notice) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notice.title
        content.body = notice.body
        content.categoryIdentifier = notice.categoryIdentifier
        return content
    }
}
