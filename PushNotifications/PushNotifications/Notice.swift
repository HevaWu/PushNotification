//
//  Notice.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/04.
//  Copyright © 2018 Heva. All rights reserved.
//

import Foundation
import UserNotifications

/// Notice Category Identifier
enum NoticeIdentifier: String {
    case FirstPage
    case SecondPage
    case ThirdPage
}

// MARK: - Notice

struct Notice {
    let title: String
    let body: String
    let categoryIdentifier: NoticeIdentifier
}

extension Notice {
    static func generateContent(from notice: Notice) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notice.title
        content.body = notice.body
        content.categoryIdentifier = notice.categoryIdentifier.rawValue
        return content
    }
}

// MARK: - NoticeAction

enum NoticeActionIdentifier: String {
    case ACCEPT_ACTION
    case DECLINE_ACTION
}

struct NoticeAction {
    // TODO: check options
    static let accept: UNNotificationAction = UNNotificationAction(identifier: NoticeActionIdentifier.ACCEPT_ACTION.rawValue, title: "Accept", options: UNNotificationActionOptions(rawValue: 0))
    static let decline: UNNotificationAction = UNNotificationAction(identifier: NoticeActionIdentifier.DECLINE_ACTION.rawValue, title: "Decline", options: UNNotificationActionOptions(rawValue: 0))
}

// MARK: - NoticeCategory

struct NoticeCategory {
    // TODO: define your own category here
    static let showFirstPage: UNNotificationCategory = UNNotificationCategory(identifier: NoticeIdentifier.FirstPage.rawValue, actions: [NoticeAction.accept, NoticeAction.decline], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: UNNotificationCategoryOptions.customDismissAction)
}
