//
//  ViewController.swift
//  PushNotifications
//
//  Created by ST21235 on 2018/12/03.
//  Copyright © 2018 Heva. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let notice = Notice.init(title: "First Page notice", body: "11111", categoryIdentifier: NoticeIdentifier.FirstPage)
        NoticeService.shared.noticeManager.append(notice)
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let notice = Notice.init(title: "Second Page notice", body: "22222", categoryIdentifier: NoticeIdentifier.SecondPage)
        NoticeService.shared.noticeManager.append(notice)
    }
}

class ThirdViewController: UIViewController {

}

